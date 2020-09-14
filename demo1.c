#include <uvsqgraphics.h>

// ############################
// Démo 1 de l'API uvsqgraphics
// Dans geany, cliquer sur <.> pour compiler
// et sur la coche à droite de <.> pour exécuter
// ############################


int main () {
    POINT P1, P2;
    init_graphics (800,600);
    fill_screen (antiquewhite);

// Affichage d'un disque et d'un cercle
    P1.x = 200; P1.y = 300;
    draw_fill_circle(P1,50,blueviolet);
    draw_circle(P1,40,white);

// Affichage d'un rectangle avec un bord d'une couleur différente
    P2.x = 100; P2.y = 100;
    draw_fill_rectangle(P1,P2,violetlight);
    draw_rectangle(P1,P2,violet);

// Affichage de texte de taille 20
    char *a_ecrire = "Cliquer dans la fen"ecirc"tre";
    P1.x = LARGEUR_FENETRE/2 - largeur_texte(a_ecrire,20)/2; 
    P1.y = 2*hauteur_texte(a_ecrire,20);
    aff_pol(a_ecrire,20,P1,gris);

// Attente d'un clic
    P2 = wait_clic();
// Remplissage de l'écrans
    fill_screen(lavender);
// Affichage d'un cercle centré sur le point cliqué
    P1.x = LARGEUR_FENETRE/2 - largeur_texte(a_ecrire,20)/2; 
    aff_pol(a_ecrire,20,P1,gris);
    P2 = wait_clic();
    draw_fill_circle(P2,80,crimson);

// Affichage d'un cercles centré sur le point cliqué
    P2 = wait_clic();
    draw_fill_circle(P2,80,rouge);

// Attente de l'appui sur la touche Echap pour terminer
    wait_escape();
    exit(0);
}
