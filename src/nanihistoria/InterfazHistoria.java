/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nanihistoria;

import java.awt.Color;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JRootPane;
import javax.swing.JScrollPane;
import javax.swing.SwingUtilities;
import javax.swing.Timer;
import javax.swing.filechooser.FileSystemView;
import org.jpl7.Query;

/**
 *
 * @author usuario1
 */
public class InterfazHistoria extends javax.swing.JFrame {

    /**
     * Creates new form InterfazHistoria
     */
    
    BufferedImage cocina = null;
    BufferedImage comedor = null;
    BufferedImage test = null;
    BufferedImage pasillo1 = null;
    BufferedImage sala1 = null;
    BufferedImage hell = null;
    
    
    //BufferedImage Low = null;
    Timer tr = null;
    String textoImprimir = null;
    
    public InterfazHistoria() {
        initComponents();
        setLocationRelativeTo(null);
        
        
        //TextArea transparente
        output.setBackground(new Color((float) 0,(float) 0,(float) 0, (float) 0.8));
        personajeField.setBackground(new Color((float) 0,(float) 0,(float) 0, (float) 0.8));
        //input.setBackground(new Color((float) 1,(float) 1,(float) 1, (float) 0.8));
        
        jScrollPane1.getViewport().setOpaque(false);
        jScrollPane1.setOpaque(false);
        //output.setBorder(javax.swing.BorderFactory.createLineBorder(Color.BLACK));
        //output.setBorder(javax.swing.BorderFactory.createEmptyBorder());
        
        //Boton por default
        JRootPane rootPane = SwingUtilities.getRootPane(enter); 
        rootPane.setDefaultButton(enter);
        
        //Que el texto se acomode al tamaño del textarea y no haga scroll horizontal
        output.setLineWrap(true);
        output.setWrapStyleWord(true);
        
        
        
                    
        
        try {
            test = ImageIO.read(new File("Imagenes/test.jpg"));
            cocina = ImageIO.read(new File("Imagenes/cocina.jpg"));
            comedor = ImageIO.read(new File("Imagenes/comedor.jpg"));
            pasillo1 = ImageIO.read(new File("Imagenes/pasillo1.jpg"));
            sala1 = ImageIO.read(new File("Imagenes/sala1.jpg"));
            hell = ImageIO.read(new File("Imagenes/hell.jpg"));
            //Low = ImageIO.read(new File("Imagenes/Low.png"));
        } catch (IOException e) {
        }
        fondo.setImage(test);
        //imageLabel1.setImage(img2);
        
        
        String t1 = "consult('Prolog/Historia.pro')";//aqui colocan el nombre de su archivo a compilar
        Query q1 = new Query(t1);
        System.out.println(t1 + " " + (q1.hasSolution() ? "verdadero" : "fallo"));
        
        
        
    }

    
    private void colocarFondo(){
        
        
        try {
            String consulta = "ubicación(X)";
            Query q = new Query(consulta);
            String respuesta = q.oneSolution().get("X").toString();
            
            switch (respuesta) {
                case "cocina":
                    fondo.setImage(cocina);
                    break;
                case "comedor":
                    fondo.setImage(comedor);
                    break;
                case "pasillo1":
                    fondo.setImage(pasillo1);
                    break;
                case "sala1":
                    fondo.setImage(sala1);
                    break;
                case "hell":
                    fondo.setImage(hell);
                    break;
                default:
                    fondo.setImage(test);
                    break;
            }
        } catch (NullPointerException e) {
            fondo.setImage(test);
        }
        
    }
    
    private boolean pideRespuesta(){
        
        String consulta = "pide_respuesta(_)";
        Query q = new Query(consulta);
        
        return q.hasSolution();
        
    }
    
    private void colocarTextoSalida(){
        
        output.setText("");
        tr.start();
        
        
        
        
        
//        String[] textoPersonajes = entrada.split("&&"); //Entradas de diferentes personajes
//        
//        for (int i = 0; i < textoPersonajes.length; i++) {
//            String[] subEntrada = textoPersonajes[i].split("&");
//            String personaje = subEntrada[0];
//            String texto = subEntrada[1];
//            
//            if(personaje.equals("Lo")){
//                output.setFont(new java.awt.Font("Comic Sans MS", 0, 18));
//                output.setText("-Lo\n");
//            }else if(personaje.equals("Consola")){
//                output.setFont(new java.awt.Font("Monospaced", 0, 16));
//                output.setText("");
//            }
//            
//            
//            //delayText(texto);
//            //output.setText(texto); 
//        }
        
        
        
        
//        String personaje = subTexto[0];
//        String texto = subTexto[1];
//        
//        System.out.println(personaje);
//        System.out.println(texto);
//        
//        
//        
//        
//        
//        
//        output.setText(texto);
        
        
        
        //output.setFont(new java.awt.Font("Monospaced", 0, 16)); //Consola
        //output.setFont(new java.awt.Font("Consolas", 0, 18));
        //output.setFont(new java.awt.Font("Comic Sans MS", 0, 18)); //Lo
        
    }
    
    
    
    
    
    
    boolean forzarAvance = false;
    boolean debeIniciarTimer = true;
    
    
    
    private void inicializarTimer(){
        
        
        
        tr = new Timer(40, new ActionListener() {
            
            
            int i = 0;
            String textoEntero = textoImprimir;
            String[] textoPersonaje = textoEntero.split("&&");
            int contadorPersonaje = 0;
            int contadorPedazoTexto = 0;
            
            
            
            
            public void actionPerformed(ActionEvent e) {
                debeIniciarTimer = false;
                String[] separadoPersonajeTexto = textoPersonaje[contadorPersonaje].split("&");
                
                String personaje = null;
                String texto = null;
                
                if (separadoPersonajeTexto.length <= 1) { //si no existe personaje, usar "Consola" por defecto
                    personaje = "Consola";
                    texto = separadoPersonajeTexto[0];
                }else{
                    personaje = separadoPersonajeTexto[0];
                    texto = separadoPersonajeTexto[1];
                }
                
                
                String[] pedazoTexto = texto.split("%");
                
                //Personaje interfaz
                personajeField.setText(personaje);
                
                
                
                //////////// Perzonalizar por personaje ////////////////////////7
                
                if(personaje.equals("Lo")){
                    output.setFont(new java.awt.Font("Comic Sans MS", 0, 25));
                    imagenPersonaje.setVisible(true);
                    imagenPersonaje.setIcon(new ImageIcon("Imagenes/Low.png"));
                    //output.setText("-Lo\n");
                }else if(personaje.equals("Consola")){
                    output.setFont(new java.awt.Font("Monospaced", 0, 16));
                    imagenPersonaje.setVisible(false);
                    //output.setText("**");
                }else if(personaje.equals("400")){
                    output.setFont(new java.awt.Font("MingLiU_HKSCS-ExtB", 0, 25));
                    imagenPersonaje.setVisible(true);
                    imagenPersonaje.setIcon(new ImageIcon("Imagenes/400.png"));
                }else if(personaje.equals("Low2")){
                    output.setFont(new java.awt.Font("Comic Sans MS", 3, 24));
                    imagenPersonaje.setVisible(true);
                    imagenPersonaje.setIcon(new ImageIcon("Imagenes/Low2.png"));
                }
                ////////////////////////////////////////////////////
                ///////////////// Tiempo signos ////////////////////
                
                if (forzarAvance) {
                    ((Timer) e.getSource()).setDelay(0);
                }else{
                    switch (pedazoTexto[contadorPedazoTexto].charAt(i)) {
                        case ',':
                            ((Timer) e.getSource()).setDelay(400);
                            break;
                        case '.':
                            ((Timer) e.getSource()).setDelay(600);
                            break;
                        default:
                            ((Timer) e.getSource()).setDelay(40);
                            break;
                    }
                }
                
                
                output.append(String.valueOf(pedazoTexto[contadorPedazoTexto].charAt(i++)));
                
                
                /////////////////////////////////////
                /////////////////////////////////////
                
                if (i == pedazoTexto[contadorPedazoTexto].length()){//Cuando termine de imprimir todos los caracteres
                    ((Timer) e.getSource()).stop();
                    i = 0;
                    contadorPedazoTexto++;
                    forzarAvance = false;
                    
                    if (contadorPedazoTexto == pedazoTexto.length) { //Cuando termine de imprimir todos los pedazos de texto de un personaje
                        contadorPersonaje++;
                        contadorPedazoTexto = 0;
                    } 

                    if(contadorPersonaje == textoPersonaje.length){// Cuando termine todos los textos de los personajes
                        debeIniciarTimer = true;
                    }else{
                        output.append("\n\n *Presiona enter para continuar...*");
                    }
                    
                }
            
                
                
//            output.append(String.valueOf(textoImprimir.charAt(i++)));
//                if (i == textoImprimir.length()){
//                    ((Timer) e.getSource()).stop();
//                    i = 0;
//                }    
            }
        } );
        
    }
    
    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        fondo = new nanihistoria.ImageLabel();
        enter = new javax.swing.JButton();
        input = new javax.swing.JTextField();
        jScrollPane1 = new javax.swing.JScrollPane();
        output = new javax.swing.JTextArea();
        comando = new javax.swing.JTextField();
        personajeField = new javax.swing.JTextField();
        imagenPersonaje = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Calalini");
        setBackground(new java.awt.Color(204, 204, 255));
        setResizable(false);
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        fondo.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        enter.setText("enter");
        enter.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                enterActionPerformed(evt);
            }
        });
        fondo.add(enter, new org.netbeans.lib.awtextra.AbsoluteConstraints(380, 0, 92, 40));

        input.setFont(new java.awt.Font("Consolas", 1, 18)); // NOI18N
        fondo.add(input, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, 380, 40));

        output.setEditable(false);
        output.setBackground(new java.awt.Color(0, 0, 0));
        output.setColumns(20);
        output.setFont(new java.awt.Font("Arial", 0, 10)); // NOI18N
        output.setForeground(new java.awt.Color(255, 255, 255));
        output.setRows(5);
        output.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                outputKeyPressed(evt);
            }
        });
        jScrollPane1.setViewportView(output);

        fondo.add(jScrollPane1, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 430, 1120, 220));

        comando.setEditable(false);
        comando.setFont(new java.awt.Font("Consolas", 0, 14)); // NOI18N
        fondo.add(comando, new org.netbeans.lib.awtextra.AbsoluteConstraints(470, 0, 270, 40));

        personajeField.setEditable(false);
        personajeField.setBackground(new java.awt.Color(0, 0, 0));
        personajeField.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        personajeField.setForeground(new java.awt.Color(255, 255, 255));
        fondo.add(personajeField, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 390, 210, 50));
        fondo.add(imagenPersonaje, new org.netbeans.lib.awtextra.AbsoluteConstraints(620, 0, 510, 440));

        getContentPane().add(fondo, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, 1120, -1));

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void enterActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_enterActionPerformed
        String preConsulta = input.getText();
        
         String consulta;
        if (pideRespuesta()) {
            consulta = "respuesta_loop('"+preConsulta+"')";
        }else{
            consulta = "command_loop('"+preConsulta+"')";
        }
        
       
        
        Query q = new Query(consulta);
        q.hasSolution();

        input.setText("");
        comando.setText(preConsulta);

        //Añadir fondo
        colocarFondo();
        
        
        
        //FileSystemView filesys = FileSystemView.getFileSystemView();

        //File[] roots = filesys.getRoots();

        
        //JOptionPane.showMessageDialog(null, filesys.getHomeDirectory());
        
        String resultadoConsulta = getFileText("texto.txt");
        
        
        textoImprimir = resultadoConsulta;
        if (debeIniciarTimer) {
            inicializarTimer();
            colocarTextoSalida();
        }
        
        
    }//GEN-LAST:event_enterActionPerformed

    private void outputKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_outputKeyPressed
       
        if (tr != null){
        
            if (tr.isRunning()) {
                forzarAvance = true;
            }else{
                if (!debeIniciarTimer) {
                    output.setText("");
                    tr.start();
                }
            }
        }
 
        
    }//GEN-LAST:event_outputKeyPressed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(InterfazHistoria.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(InterfazHistoria.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(InterfazHistoria.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(InterfazHistoria.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new InterfazHistoria().setVisible(true);
            }
        });
    }

    public static String getFileText(String ruta){
        FileInputStream fis = null;
        String str = "";
        try {
            File file = new File(ruta);
            fis = new FileInputStream(file);
            byte[] data = new byte[(int) file.length()];
            try {
                fis.read(data);
            } catch (IOException ex) {
                Logger.getLogger(InterfazHistoria.class.getName()).log(Level.SEVERE, null, ex);
            }
            fis.close();
            //str = new String(data, "UTF-8");
            str = new String(data, "ISO-8859-1");
        } catch (FileNotFoundException ex) {
            Logger.getLogger(InterfazHistoria.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(InterfazHistoria.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                fis.close();
            } catch (IOException ex) {
                Logger.getLogger(InterfazHistoria.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    return str;
    }
    
    public void delayText(String str){
        new Timer(60, new ActionListener() {
            int i = 0;
            public void actionPerformed(ActionEvent e) {
                
                output.append(String.valueOf(str.charAt(i++)));
                if (i == str.length())((Timer) e.getSource()).stop();
                
            }
        }).start();
    }
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTextField comando;
    private javax.swing.JButton enter;
    private nanihistoria.ImageLabel fondo;
    private javax.swing.JLabel imagenPersonaje;
    private javax.swing.JTextField input;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTextArea output;
    private javax.swing.JTextField personajeField;
    // End of variables declaration//GEN-END:variables
}
