
package com.Phylix;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EnviaMail {
    public static void enviaCorreo(String correo, String asunto, String motivo) {
        String de = "torres.trejo.abraham@gmail.com" ;
        String password = "ntah flvs egde xqqc";
        
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(de, password);
            }
        });

        session.setDebug(true);
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(de));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(correo));
            message.setSubject(asunto);
            message.setText(motivo);

            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}