package com.Phylix;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EnviaMail {
    public static void enviaCorreo(String correo, String asunto, String motivo) {
        String de = "phylix.fitdata@gmail.com";
        String noreply = "no-reply@phylix.fitdata.com";
        String nombre = "FitData";
        
        String password = "rbgq pbwo qnsg eyqq";

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
            message.setFrom(new InternetAddress(noreply, nombre));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(correo));
            message.setSubject(asunto);
            message.setContent(motivo, "text/html; charset=utf-8");

            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
