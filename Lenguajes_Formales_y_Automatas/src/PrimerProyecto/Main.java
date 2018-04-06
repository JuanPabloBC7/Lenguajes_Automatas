 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package PrimerProyecto;

import java.io.File;
/**
 *
 * @author juan pablo
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) 
    {
        String Peth = "C:/Users/juan pablo/Documents/NetBeansProjects/Lenguajes_Formales_y_Automatas/src/PrimerProyecto/MiniPHP.flex";
        Siguiente1(Peth);
        // TODO code application logic here
    }
    public static void Siguiente1(String Salida)
    {
        File F = new File(Salida);
        jflex.Main.generate(F);
        Interface I = new Interface();
        I.setVisible(true);
    } 
}
