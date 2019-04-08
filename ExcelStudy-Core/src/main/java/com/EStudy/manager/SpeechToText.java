/*
 * Copyright 1999-2004 Carnegie Mellon University.
 * Portions Copyright 2004 Sun Microsystems, Inc.
 * Portions Copyright 2004 Mitsubishi Electric Research Laboratories.
 * All Rights Reserved.  Use is subject to license terms.
 *
 * See the file "license.terms" for information on usage and
 * redistribution of this file, and for a DISCLAIMER OF ALL
 * WARRANTIES.
 *
 */

package com.EStudy.manager;

import java.util.ArrayList;
import java.util.List;

/**
 * A simple HelloWorld demo showing a simple speech application 
 * built using Sphinx-4. This application uses the Sphinx-4 endpointer,
 * which automatically segments incoming audio into utterances and silences.
 */
public class SpeechToText {

    /**
     * Main method for running the HelloWorld demo.
     */
    public static void main(String[] args) {
        String test = "-$$$$-$$$$-";
        String[] testData = test.split("\\$\\$\\$\\$");
        for(String tes:testData){
            System.out.println("::::::::"+tes);
        }

        List<String> test1 = new ArrayList<>();
        test1.add("-");
        test1.add("-");
        test1.add("-");
        System.out.println("Size is ::::::"+test1.size());
        if(!test1.get(0).equals("-")){
            System.out.println("Came here:::: 1");
        }
        if(!test1.get(1).equals("-")){
            System.out.println("Came here::::2 ");
        }
        if(!test1.get(test1.size()-1).equals("-")){
            System.out.println("Came here::::3");
        }


    }
}