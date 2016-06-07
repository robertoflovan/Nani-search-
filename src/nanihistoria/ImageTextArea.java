/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nanihistoria;

import java.awt.Graphics;
import java.awt.Image;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.JTextArea;

/**
 *
 * @author usuario1
 */

public class ImageTextArea extends JTextArea { //No se utiliza para el proyecto

    private Image img;

    public ImageTextArea() {
        try{
            img = ImageIO.read(new File("C:/Users/usuario1/Desktop/Victorian.png"));
        } catch(IOException e) {
            System.out.println(e.toString());
        }
    }
    
    public ImageTextArea(int a, int b) {
        super(a,b);
        try{
            img = ImageIO.read(new File("C:/Users/usuario1/Desktop/Victorian.png"));
        } catch(IOException e) {
            System.out.println(e.toString());
        }
    }

    @Override
    protected void paintComponent(Graphics g) {
        g.drawImage(img,0,0,null);
        super.paintComponent(g);
    }
}