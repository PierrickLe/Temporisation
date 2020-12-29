// ------------------------------------------------------------------------------------------------
// 
// Temporisation au lancement et l'arrêt de la HT et chauffage filaments pour un ampli à tube
// Gestion par appele de fonctions 
// Controle de la présence du chaufage des filaments en marche
// Controle de la temperature interne du boitier
// Gestion de l'affichage
// Gestion impédance du casque 300/600 Ohm par bouton poussoir
// Pierrick , aucuns droits reservés 
// version  1.33
//
// -------------------------------------------------------------------------------------------------

// import des bibliothèques pour gestion ecran //////////////////////////////////
#include <hd44780.h>  
#include <hd44780ioClass/hd44780_pinIO.h> 
const int rs=6, en=7, db4=2, db5=3, db6=4, db7=5;       // déclaration de l'écran
hd44780_pinIO  ecranLCD(rs, en, db4, db5, db6, db7);   // Activation de l'écran

// définition des variables  /////////////////////////////////////////////////////
#define TENSION_REF   4.58            // Tension de l'arduino a régler en situation
#define NB_MESURE  6                  // Non=mbre de mesure de la tension du chauffage filament avant de faire une moyenne
#define PIN_ENTREE_BOUTON_ON_OF 14    // bouton gérant le On Off A0
#define PIN_ENTREE_BOUTON_CASQUE 15   // bouton gérant le casque A2
#define PIN_ENTREE_BOUTON_INFO 16     // bouton gérant les infos 
#define TEMPS_ANTI_REBOND_MS 30       // temps "d'anti-rebond", en millisécondes, pendant lequel les rebonds seront ignorés
#define CARACTERE_OHM ((byte) 0 )     // creation caractere OHM pour l'afficher sur le LCD

unsigned char compteur_simple = 0;    // compteur pour les mesures de tensions
int somme_valeur_tension = 0;         // le total des mesures
float tension_lue = 0.0;              // tension calculée pour ctrl filament
int tension_filament= 0;              // retourne 1 si 6.15V< tension filamant <3.40V

unsigned long date;                   // date pour compter les secondes
unsigned long affichage_ON;           // comparaison date pour mettre l'affichage en veuille au bourt de 20 secondes
int secondes = 0;                     // compteur de secondes pour régler la temporisation au départ compte jusqu'a 98 secondes

const int sensorPin = A3;             // Capteur temperature sur A3
const float baselineTemp = 28.5;      // température max avant déclenchement relais ventilation à régler en situation

/// gestion des variables pour les boutons   /////////////////////////////// 
bool boutonAppuye_ON_OF = false;      
bool boutonAppuye_CASQUE = false;     // initialisée avec le bouton non-appuyé (donc relaché)
bool boutonAppuye_INFO = false;

unsigned long dateAntiRebond_ON_OF = 0;// compteur de temps pour l'anti-rebond, initialisé à 0 ce qui veut
unsigned long dateAntiRebond_CASQUE = 0;
unsigned long dateAntiRebond_INFO = 0; // dire qu'il n'y a pas d'anti-rebond en cours  

bool Etat_precedent_ON_OF = 1;        //etat au depart  du system a 1 pour lancer la temporisation
bool Etat_precedent_CASQUE = 0;       //etat 0=300 Ohm etat 1 = 600 Ohm
bool Etat_precedent_INFO = 0;         //etat du bouton au depart

// gestion des variables pour les relais   //////////////////////////
const int relais_FILAMENT = 9;         
const int relais_HT = 10;
const int relais_CASQUE = 11;
const int relais_VENTILATEUR = 12;
// fin définition des variables /////////////////////////////////////////

void setup()
    {  
// Déclaration de l'activation des 4 relais
    pinMode(relais_VENTILATEUR, OUTPUT);
    pinMode(relais_FILAMENT, OUTPUT);
    pinMode(relais_HT, OUTPUT);
    pinMode(relais_CASQUE, OUTPUT);

// Déclaration des boutons poussoirs 
    pinMode(PIN_ENTREE_BOUTON_ON_OF, INPUT_PULLUP);
    pinMode(PIN_ENTREE_BOUTON_CASQUE, INPUT_PULLUP);
    pinMode(PIN_ENTREE_BOUTON_INFO, INPUT_PULLUP);

// Déclaration du port USB pour affichage sur PC
    Serial.begin(9600);
    Serial.println("Version V1.33");
    Serial.print(F("Initialize System")); Serial.print(" --> btnState_ON_OFF = "); Serial.println(Etat_precedent_ON_OF);

// Configuration de l'écran selon sa capacité d'affichage : 16 colonnes X 2 lignes
    ecranLCD.begin(16, 2);

// définition et création du caractère ohm
    byte matriceOhm[8] = {0B00000, 0B00000, 0B01110, 0B10001, 0B10001, 0B01010, 0B11011, 0B00000,}; 
    ecranLCD.createChar(CARACTERE_OHM, matriceOhm);
           
// Déclaration des contact de relais  en position  ouverte  
    digitalWrite(relais_FILAMENT, HIGH);    
    digitalWrite(relais_HT, HIGH);
    digitalWrite(relais_CASQUE, HIGH);
    digitalWrite(relais_VENTILATEUR, HIGH); 

//Lancement de la mise de route a l'actvation du 220V.
    fct_ON(); 
// lancement de la mise en veille de l'affichage    
    affichage_ON = millis();
    }

///////////////////////////////////////////////////////////////////////////////////////////////////////// 
void loop()
{
// initialiser la date 
    date = millis();

// Initialisation de l'état du bouton poussoir  ON OFF
    EtatDuBouton(PIN_ENTREE_BOUTON_ON_OF, boutonAppuye_ON_OF, dateAntiRebond_ON_OF, Etat_precedent_ON_OF);   

// Verification  du systeme 
    // tension_filament == 1 && Etat_precedent_ON_OF == 1 ==> etat nominal

    // tension_filament == 1 && Etat_precedent_ON_OF == 0 ==> appui sur mise en veille
    if ( tension_filament == 1 && Etat_precedent_ON_OF == 0 ){
      fct_OFF();
    }
    // tension_filament == 0 && Etat_precedent_ON_OF == 0 ==> etat en veille
    if ( tension_filament == 0 && Etat_precedent_ON_OF == 0 ){
      ecranLCD.noDisplay();
    }
    // tension_filament == 0 && Etat_precedent_ON_OF == 1 ==> appui sur mise en route ou sortie de veille     
    if ( tension_filament == 0 && Etat_precedent_ON_OF == 1 ){
      fct_ON();      
    }
// Mesure de la tension filament 6.3V
    tension_lue = fct_Controle_tension_filament();

//Test de la tension des filaments des tubes 6.3V    
        if ( tension_lue  > 5.70  && tension_lue < 6.47 && Etat_precedent_ON_OF == 1) {
            digitalWrite(relais_HT,LOW );  //fonctionnement nominal
            tension_filament= 1;
          }
        else if (Etat_precedent_ON_OF == 1){
             tension_filament= 2; // disfonctionnement
             fct_defaut();
          }
        else // fct normal appuie sur bouton ON OFF
          {       
            tension_filament= 0;          
          }
// Initialisation de l'état du bouton poussoir CASQUE  
    EtatDuBouton(PIN_ENTREE_BOUTON_CASQUE, boutonAppuye_CASQUE, dateAntiRebond_CASQUE,Etat_precedent_CASQUE);    
        
// Test de l'état du bouton casque
    if (Etat_precedent_CASQUE ==0) {         
          ecranLCD.clear();
          ecranLCD.print("300 ");
          digitalWrite(relais_CASQUE, HIGH);  
        }
        else {          
          ecranLCD.clear();
          ecranLCD.print("600 ");
          digitalWrite(relais_CASQUE, LOW);
        }
    ecranLCD.write(CARACTERE_OHM); 
    ecranLCD.print(" ");      
    ecranLCD.print(tension_lue);
    ecranLCD.print( "V " );  
    //ecranLCD.print(tension_filament);  
    fct_Controle_temperature(relais_VENTILATEUR);

// Initialisation de l'état du bouton poussoir INFO     
    EtatDuBouton(PIN_ENTREE_BOUTON_INFO,boutonAppuye_INFO, dateAntiRebond_INFO,Etat_precedent_INFO); 

// Bouton info 
    if (Etat_precedent_INFO == 1) {  fct_Affichage();  }
    
// Mise en veuille du LCD au bout de 25 secondes 
    fct_Affichage_OFF();
		delay(100);   
}
//*****************     Déclaration des fonctions     *****************
///////////////////////////////////////////////////////////////////////
void fct_Affichage(){
// fonction non develloppée actuellement
    ecranLCD.clear();
    ecranLCD.setCursor(0, 0);
    ecranLCD.print("!! Pas d'info  !!" );  
    ecranLCD.setCursor(0, 1);
    ecranLCD.print("!! Pas d'info  !!" );       
    ecranLCD.print(tension_lue);
    delay(5000);
    Etat_precedent_INFO = 0;
  }
  ///////////////////////////////////////////////////////////////////////
void fct_Affichage_OFF(){
// Mise en veuille du LCD au bout de 25 secondes
    if (date  > affichage_ON + 25000) {
      ecranLCD.noDisplay();
      affichage_ON = date;}
  }
///////////////////////////////////////////////////////////////////////
void fct_defaut(){
//Coupure de la HT, puis affichage defaut puis arrêt chauffage filament apres 30 secondes
      ecranLCD.display();  
      ecranLCD.setCursor(0, 0);
      ecranLCD.print("!!!  Defaut  !!!" );  
      ecranLCD.setCursor(0, 1);
      if (tension_filament == 2){
        digitalWrite(relais_HT, HIGH);
        ecranLCD.print("Chauffage 6.3V   " ); 
        Etat_precedent_ON_OF=0;
        delay(30000);
        digitalWrite(relais_FILAMENT, HIGH);        
        tension_filament = 0; 
        }
      }
///////////////////////////////////////////////////////////////////////
void fct_OFF(){
// Coupure HT et réinit des variables avant mise en veille du systeme
      digitalWrite(relais_HT, HIGH);
      digitalWrite(relais_CASQUE, HIGH);
      Etat_precedent_CASQUE=0;
      Etat_precedent_INFO = 0; 
      tension_filament = 0;      
      ecranLCD.clear();
      ecranLCD.print("Arret tension HT " );
      ecranLCD.setCursor(0, 1);
      ecranLCD.print("Mise en veille " );
//Mise en route d'un temporisation avant de couper le chauffage des filaments   
     delay(40000);  // on peut bloquer toute autre action   
// Coupure du relais  du chaufage filaments
      digitalWrite(relais_FILAMENT, HIGH);    
  }
///////////////////////////////////////////////////////////////////////
void fct_ON(){
    // Activation du relais  du chaufage filaments  fermeture du contact
      digitalWrite(relais_FILAMENT, LOW); 
      tension_filament =1;
    //Mise en route temporisation de préchauffage  
      ecranLCD.display();
      ecranLCD.clear();  
      fct_temporisation();
      affichage_ON = millis();
  }
///////////////////////////////////////////////////////////////////////
void EtatDuBouton(int entreeDigitale,             // Paramètre : entrée digitale à lire
                  bool &boutonAppuye,             // Paramètre : état du bouton
                  unsigned long &dateAntiRebond,  // Paramètre : état de l'anti-rebond
                  bool &Etat_precedent)          // Paramètre : compteur de clicks
{
// Lire l'état de l'entrée dans une variable temporaire
    bool etatSignal = !digitalRead(entreeDigitale);
    // si le bouton semble avoir été appuyé (pas de signal, ou signal = 0/false)
    if ( etatSignal )
    {
        // si l'anti-rebond est déjà en train d'ignorer les rebonds
        if ( dateAntiRebond != 0 )
          {
            // obtenir et déterminer combien de temps s'est écoulé depuis le début 
            // de l'anti-rebond ( = date actuelle - date de début)
            unsigned long tempsEcoule = millis() - dateAntiRebond;
            // si le temps écoulé est supérieur ou égal au temps d'anti-rebond
            if ( tempsEcoule >= TEMPS_ANTI_REBOND_MS )
              {
               // On considére alors que le bouton est appuyé et on arrête l'anti-rebond
                boutonAppuye = true;
                dateAntiRebond = 0;
                // comme le bouton vient d'être considéré comme appuyé (front montant) on change son etat 
                Etat_precedent=!Etat_precedent;
                // On réinitialise la tempo de l'affichage suite action sur un boutton et l'affichage ecran
                affichage_ON = millis();
                ecranLCD.display();
                // Affichage sur sortie USB pour test 
                Serial.print("Clicks sur le bouton sur l'entree ");
                Serial.print(entreeDigitale);
                Serial.print(" : ");
                Serial.print(Etat_precedent_ON_OF);
                Serial.print(" : ");
                Serial.print(Etat_precedent_CASQUE);
                Serial.print(" : ");
                Serial.print(Etat_precedent_INFO);
                Serial.print(" : ");
                Serial.println(tension_filament);
                
              }
        }
        // sinon, si le bouton est actuellement considéré comme relaché
        else if ( !boutonAppuye )
          {
            // activation de l'anti-rebond à la date actuelle du système
            dateAntiRebond = millis();
          }
          // sinon, le bouton est déjà considéré comme appuyé, il n'y a rien à faire
    }
    // sinon, le bouton semble avoir été relaché
    else
    {        
        // si le bouton était appuyé
        if ( boutonAppuye )
        {
            // le considérer maintenant comme relaché
            boutonAppuye = false;
        }
        // sinon, le bouton était déjà relaché ou l'anti-rebond était en cours
        else
        {            
            // arrêter l'anti-rebond s'il était en cours
            dateAntiRebond = 0;
        }
    }
}
//////////////////////////////////////////////////////////////////////////////////////
float fct_Controle_tension_filament() {
// Controle de la tension d'alimentation des filaments
//On prend une mesure toute les 10 milliseconses NB_MESURE
    while (compteur_simple < NB_MESURE) {
       somme_valeur_tension +=    analogRead(A5);      
        compteur_simple++;
        delay(10);
    }
// Calcul de la tension  avec TENSION_REF tension de l'arduino 
    tension_lue = ((float)somme_valeur_tension / (float)NB_MESURE * TENSION_REF) / 1024.0;
  
// On remultiplie par le pont diviseur 100K et 10K mais  valeur précise = 99.71K et 9.889K    
//    Serial.println(somme_valeur_tension / (float)NB_MESURE );Serial.print(tension_lue * 11.135);Serial.println (" V");
    compteur_simple = 0;
    somme_valeur_tension = 0;   
    return tension_lue * 11.135;
  }
/////////////////////////////////////////////////////////////////////////////////////
void	fct_Controle_temperature(char  nom_relais) {
//Fonction pour boitier fermé avec enclenchement d'un relais pour un ventilateur
    int senrorVal = analogRead(sensorPin); 
		float voltage = (senrorVal/1024.0) * TENSION_REF;
		float temperature = (voltage - .5) * 100;	
    ecranLCD.setCursor(0, 1);
    ecranLCD.print("Temperature:" );
		if (temperature <= baselineTemp) {
          digitalWrite(nom_relais, HIGH);
        }
        else
        {
          ecranLCD.setCursor(0, 1);
          ecranLCD.print("Attention :" );
          digitalWrite(nom_relais, LOW);
        }
          ecranLCD.setCursor(14, 1);
          ecranLCD.print(temperature);	
	}		
/////////////////////////////////////////////////////////////////////////////////////
void fct_temporisation(void)  {
//temporisation de départ reglable entre secondes et 99
  while (secondes < 60)
    {
// date courante
      unsigned long maintenant = millis();
      
// si une seconde s'est écoulée
      if ( (maintenant - date) >= 1000 )
        {
          // mettre à jour la date pour compter la prochaine seconde
          date = maintenant;
          Serial.print(F("tempo :  ")); Serial.print(secondes); 
          Serial.print(F(" filament :  ")); Serial.println(tension_filament); 
          // incrémenter le compteur
          secondes++;
           
          // pour ne pas déborder, recommencer à 0 une fois 99 secondes atteintes
          if ( secondes > 60 )
          {
          secondes =0;
          }
        }   
// afficher le compteur
      ecranLCD.setCursor(11, 0);
      ecranLCD.print(secondes);
      ecranLCD.print(" s");
      }
// Réinitialisation  de la variable pour les prochaines sortie de veilles      
      secondes =0;
  }
