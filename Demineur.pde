
int MARGE;
int COTE;
int nbColonne;
int nbLigne;
int nbBombe;
int nbBVoisin;
int nbDecouverte=0;

float xPos1; 
float xPos2; 
float xPos3; 

float yPos1 = 205;
float yPos2 = 360;

float coinBouton = 10;

float largeurBouton = 120;
float hauteurBouton = 70;

color blanc = color (255);
color gris = color (133, 135, 135);
color orange = color(245, 119, 0);
color rouge = color(255, 0, 0);
color vert = color(64, 164, 71);

color facilecouleur = vert;
color moyencouleur = orange;
color difficilecouleur = rouge;
color petitecouleur = vert;
color moyennecouleur = orange;
color grandecouleur = rouge;
color actifcouleur = blanc;

boolean perdu = false;
boolean gagne = false;
boolean attention = false;
boolean debut = true;
boolean jouer = false;
boolean selection = false;

boolean [][] bombe;
boolean [][] drapeau ;
boolean [][] decouverte ;
int [][] nbBombeVoisin;

boolean facilebouton = false;
boolean moyenbouton = false;
boolean difficilebouton = false;
boolean petitebouton = false;
boolean moyennebouton = false;
boolean grandebouton = false;
boolean jouerbouton = false;

Case facile_Bouton;
Case moyen_Bouton;
Case difficile_Bouton;
Case petit_Bouton;
Case moyenne_Bouton;
Case grande_Bouton;
Case jouer_Bouton;
Case menu_Bouton;



void settings() {
  size(900, 700);
}
void setup() {
}

void draw() {
  /*************  menu principal*******************************************/
  if (debut) {

    background(100, 150, 255);
    xPos1 = width/4;
    xPos2 = width/2;
    xPos3 = width*3/4;


    /***********   BOUTON NIVEAU    ***************************************/
    rectMode(CENTER);
    //if (facilebouton) {

    fill(facilecouleur);
    facile_Bouton = new Case(xPos1, yPos1, largeurBouton, hauteurBouton, coinBouton);
    facile_Bouton.Dessine_Bouton();

    fill(moyencouleur);
    moyen_Bouton = new Case(xPos2, yPos1, largeurBouton, hauteurBouton, coinBouton);
    moyen_Bouton.Dessine_Bouton();

    fill(difficilecouleur);
    difficile_Bouton = new Case(xPos3, yPos1, largeurBouton, hauteurBouton, coinBouton);
    difficile_Bouton.Dessine_Bouton();


    /***********   BOUTON GRILLE    ******************************************/
    fill(petitecouleur);
    petit_Bouton = new Case(xPos1, yPos2, largeurBouton, hauteurBouton, coinBouton);
    petit_Bouton.Dessine_Bouton();

    fill(moyennecouleur);
    moyenne_Bouton = new Case(xPos2, yPos2, largeurBouton, hauteurBouton, coinBouton);
    moyenne_Bouton.Dessine_Bouton();

    fill(grandecouleur);
    grande_Bouton = new Case(xPos3, yPos2, largeurBouton, hauteurBouton, coinBouton);
    grande_Bouton.Dessine_Bouton();


    /***********  BOUTON JOUER     ******************************************/
    fill(gris);
    jouer_Bouton = new Case(xPos2, 500, 210, 60, 4);
    jouer_Bouton.Dessine_Bouton();

    fill(0);
    text("JOUER !", xPos2, 500);


    /***********       TEXTE       ****************************************/
    fill(0);
    textAlign(CENTER, CENTER);

    textSize(60);
    text("DEMINEUR", xPos2, 50);

    textSize(30);
    text("Choisir un niveau de Difficulté", xPos2, 145);
    text("Choisir une taille de Grille", xPos2, 300);

    /***********       TEXTE BOUTON       *********************************/
    textSize(20);
    text("Facile", xPos1, yPos1);
    text("Moyen", xPos2, yPos1);
    text("Difficile", 3*xPos1, yPos1);

    text("Petite", xPos1, yPos2);
    text("Moyenne", xPos2, yPos2);
    text("Grande", 3*xPos1, yPos2);


    if (attention) {
      fill(250, 0, 0);
      text("ATTENTION : choisissez une taille et un niveau avant de jouer", xPos2, 550);
    }
  } else if (jouer) {
    background(100, 150, 255);


    for (int i= 0; i<nbColonne; i++) {
      for (int j=0; j<nbLigne; j++) {

        if ( drapeau[i][j]==true && decouverte[i][j]==false) {
          fill(orange); 
          Dessine_Case(i, j);
        } else {
          if (decouverte[i][j]==true) {

            if (bombe[i][j]) {
              fill(blanc);
              Dessine_Case(i, j);
              Dessine_Bombe(i, j);
              perdu = true;
            } else {
              Nb_Bombe_Voisin(i, j);

              if (nbBombeVoisin[i][j] == 0) {

                Devoile_Case(i, j);
                fill(blanc);
                Dessine_Case(i, j);
              } else {
                fill(blanc);
                Dessine_Case(i, j);
                Dessine_Valeur(i, j);
              }
              nbDecouverte++;
            }
          } else {
            fill(gris);
            Dessine_Case(i, j);
          }
        }
      }
    }

    if (perdu== true) {

      for (int i= 0; i<nbColonne; i++) {
        for (int j=0; j<nbLigne; j++) {

          fill(blanc);
          Devoile_Case(i, j);
          if (bombe[i][j]==true) {
            Dessine_Bombe(i, j);
          }
        }
      }
      fill(rouge);
      textSize(150);
      textAlign(CENTER);
      text("PERDU !", width/2, height/2);
      textSize(30);
      fill(0);
      text("Appuyer sur la touche \" r \" pour recommencer", width/2, 600);
    }
    if (nbDecouverte==nbColonne*nbLigne-nbBombe) {
      if(perdu==false){
      gagne =true;
      nbDecouverte=0;
      }
      
      nbDecouverte=0;
    }

    if (gagne==true) {
      background(100, 50, 255);

      fill(vert);
      textSize(150);
      textAlign(CENTER);
      text("GAGNE !", width/2, height/2);
      textSize(30);
      text("Appuyer sur la touche \" r \" pour recommencer", width/2, 600);
    }
    nbDecouverte=0;
  }
}

void keyTyped() {
  if (perdu||gagne) {
    if (key=='r' || key == 'R')
    {
      gagne = false;


      debut = true;
      jouer = false;
      perdu = false;
      attention = false;
      selection = false;
      facilebouton = false;
      moyenbouton = false;
      difficilebouton = false;
      petitebouton = false;
      moyennebouton = false;
      grandebouton = false;
      jouerbouton = false;
      facilecouleur = vert;
      moyencouleur = orange;
      difficilecouleur = rouge;
      petitecouleur = vert;
      moyennecouleur = orange;
      grandecouleur = rouge;
    }
  }
} 

void mousePressed() {

  if (debut) {

    /**************  CHOIX DU NIVEAU   *************************/
    if (facile_Bouton.Selection()) {
      facilebouton = true;
      moyenbouton = false;
      difficilebouton = false;
      attention = false;
      facilecouleur = actifcouleur;
      moyencouleur = orange;
      difficilecouleur = rouge;
      println("facilebouton = true");
    }
    if (moyen_Bouton.Selection()) {
      moyenbouton = true;
      facilebouton = false;    
      difficilebouton = false;
      attention = false;
      moyencouleur = actifcouleur;
      facilecouleur = vert;
      difficilecouleur = rouge;
      println("moyenbouton = true");
    }
    if (difficile_Bouton.Selection()) {
      difficilebouton = true;
      facilebouton = false;
      moyenbouton = false;
      attention = false;
      difficilecouleur = actifcouleur;
      facilecouleur = vert;
      moyencouleur = orange;
      println("difficilebouton = true");
    }

    /**************  CHOIX DE LA TAILLE   *******************************/
    if (petit_Bouton.Selection()) {
      petitebouton = true;
      moyennebouton = false;
      grandebouton = false;
      attention = false;
      petitecouleur = actifcouleur;
      moyennecouleur = orange;
      grandecouleur = rouge;
      println("petitbouton = true");
    }
    if (moyenne_Bouton.Selection()) {
      moyennebouton = true;
      petitebouton = false;
      grandebouton = false;
      attention = false;
      moyennecouleur = actifcouleur;
      petitecouleur = vert;
      grandecouleur = rouge;
      println("moyennebouton = true");
    }
    if (grande_Bouton.Selection()) {
      grandebouton = true;
      petitebouton = false;
      moyennebouton = false;
      attention = false;
      grandecouleur = actifcouleur;
      petitecouleur = vert;
      moyennecouleur = orange;
      println("grandebouton = true");
    }

    /**************  VALIDER LES CHOIX   ****************************************************/
    if (jouer_Bouton.Selection()) {
      println("jouer ok");

      if ((petitebouton || moyennebouton || grandebouton) && (facilebouton || moyenbouton || difficilebouton)) {
        debut = false;
        jouer = true;
        if (petitebouton) {
          nbColonne = 6;
          nbLigne = 6;
          COTE = 50;
          MARGE = width/2-(COTE*6)/2;
          if (facilebouton) {
            nbBombe = 6;
          }
          if (moyenbouton) {
            nbBombe = 10;
          }
          if (difficilebouton) {
            nbBombe = 15;
          }
        }
        if (moyennebouton) {
          nbColonne = 10;
          nbLigne = 10;
          COTE = 40;
          MARGE = width*1/3-(COTE*10)/2;
          if (facilebouton) {
            nbBombe = 10;
          }
          if (moyenbouton) {
            nbBombe = 15;
          }
          if (difficilebouton) {
            nbBombe = 20;
          }
        }
        if (grandebouton) {
          nbColonne = 15;
          nbLigne = 15;
          COTE = 35;
          MARGE = width*1/3-(COTE*15)/2;
          if (facilebouton) {
            nbBombe = 20;
          }
          if (moyenbouton) {
            nbBombe = 25;
          }
          if (difficilebouton) {
            nbBombe = 35;
          }
        }

        drapeau = new boolean [nbColonne][nbLigne];
        bombe = new boolean [nbColonne][nbLigne];
        decouverte = new boolean [nbColonne][nbLigne];
        nbBombeVoisin = new int [nbColonne][nbLigne];
        for (int i= 0; i<nbColonne; i++) {
          for (int j=0; j<nbLigne; j++) {
            decouverte[i][j] = false;
          }
        }
        Genere_Bombe();
      } else {
        attention = true;
      }
    }
  } else { 
    if (jouer) {


      //********************  EVENEMENT SOURIS DROIT   ******************************************
      if (mouseButton == RIGHT) {
        if ((mouseX > MARGE && mouseY > MARGE) 
          && (mouseX < MARGE+nbColonne*COTE && mouseY < MARGE+nbLigne*COTE)) {
          int i = (int) map(mouseX, MARGE, MARGE+nbColonne*COTE, 0, nbColonne); 
          int j = (int) map(mouseY, MARGE, MARGE+nbLigne*COTE, 0, nbLigne); 


          //*********************dessine drapeau******************************************
          if (!decouverte[i][j]) {
            if (!drapeau[i][j]) {

              drapeau [i][j] = true;
            } else {
              drapeau [i][j] = false;
            }
          }
        }
      }
      //********************  EVENEMENT SOURIS GAUCHE   ******************************************
      if (mouseButton == LEFT) {

        if ((mouseX > MARGE && mouseY > MARGE) 
          && (mouseX < MARGE+(nbColonne*COTE) && mouseY < MARGE+(nbLigne*COTE))) {
          println("mouseX = "+mouseX, "mouseY = "+mouseY);
          int i = (int) map(mouseX, MARGE, MARGE+(nbColonne)*COTE, 0, nbColonne); 
          int j = (int) map(mouseY, MARGE, MARGE+(nbLigne)*COTE, 0, nbLigne); 
          println("i ="+i, "j ="+j);
          println("MARGE ="+MARGE, "COTE ="+COTE);
          println("nbLigne ="+nbLigne, "nbColonne ="+nbColonne);


          if (!drapeau[i][j]) {

            if (!decouverte[i][j]) {
              decouverte[i][j] = true;
            }
          }
        }
      }
    }
  }
}




//********************** PLACER LES BOMBES*************************************
void Genere_Bombe() {

  int nb = 0; 
  while (nb < nbBombe) {

    int x = (int) random(0, nbColonne); 
    int y = (int) random(0, nbLigne); 

    if ( bombe[x][y] == false) {
      bombe[x][y] = true; 
      nb++;
    }
  }
}

//************************ DESSINER LES BOMBES **********************************
void Dessine_Bombe(int i, int j) {

  fill(rouge); 
  ellipse(i*COTE+MARGE+25, j*COTE+MARGE+25, COTE-20, COTE-20);
}

//************************ DESSINER LES CASES ************************************
void Dessine_Case(int i, int j) {

  int x = i*COTE+MARGE+COTE/2; 
  int y = j*COTE+MARGE+COTE/2; 

  rect(x, y, COTE, COTE);
}



//********************** CALCUL NOMBRE DE BOMBE VOISIN   **********************
void Nb_Bombe_Voisin(int i, int j) {

  nbBVoisin = 0; 
  int X = i-1;
  int X1 = i+1;
  int Y = j-1;
  int Y1 = j+1;

  for (int x= X; x<=X1; x++) {
    for (int y=Y; y<=Y1; y++) {  

      if (( x>= 0 && y>=0 ) && ( x < nbColonne  && y < nbLigne)) {
        if (bombe[x][y] == true ) {
          nbBVoisin++;
        }
      }
    }
  }

  nbBombeVoisin[i][j] = nbBVoisin;
}


//********************** DESSINE NOMBRE DE BOMBE VOISIN  ***********************
void Dessine_Valeur(int i, int j) {


  textAlign(CENTER, CENTER);

  fill(0, 0, 255);
  textSize(20);
  text(nbBVoisin, MARGE+COTE/2+i*COTE, MARGE+COTE/2+j*COTE);
}

//********************** DEVOILE BOMBE VOISIN  *********************************
void Devoile_Case(int i, int j) {

  int px = i-1;
  int py = j-1;
  int qx = i+1;
  int qy = j+1;

  for (int i1= px; i1<=qx; i1++) {
    for (int j1=py; j1<=qy; j1++) {

      if ((i1 >= 0 && j1 >= 0) && (i1 < nbColonne && j1 < nbLigne) && decouverte[i1][j1] == false && bombe[i][j]==false) {

        decouverte[i1][j1] = true;
      }
    }
  }
}