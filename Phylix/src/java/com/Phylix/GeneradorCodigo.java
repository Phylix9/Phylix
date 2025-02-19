
package com.Phylix;


import java.security.SecureRandom;

public class GeneradorCodigo {
    private static String numeros = "0123456789";
    private static SecureRandom secureRandom = new SecureRandom();
    
    public static String generarCode(int length) {
        StringBuilder code = new StringBuilder();    
        for(int i = 0; i<length; i++){
            code.append(numeros.charAt(secureRandom.nextInt(numeros.length())));
        }
        return code.toString();
    }
    
}
