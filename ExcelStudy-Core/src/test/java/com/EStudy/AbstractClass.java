package com.EStudy;

/**
 * Created by praveen on 27/8/19.
 */
 abstract class AbstractClass {

    public AbstractClass(String className){
        System.out.println("ClassName is ::::::::"+className);
    }

    public void shape(){
    }

    private void innerShape(){

    }

    public void price(){

    }
}

class Bike extends AbstractClass{
    private int modelNumber;
    private int shapeDetails;

    public Bike(String className,int modelNumber,int shapeDetails) {
        super(className);
        this.modelNumber=modelNumber;
        this.shapeDetails = shapeDetails;
    }

    public void test(){

    }
    public void shape(){
        System.out.println("shapeDetails of Bike::::::::"+shapeDetails);
    }

    public void  price() {
        System.out.println("shapeDetails of Bike::::::::"+(modelNumber*10));
    }
}

class test extends Bike{
    private int modelNumber;
    private int shapeDetails;
    public test(String className, int modelNumber, int shapeDetails) {
        super(className, modelNumber, shapeDetails);
    }

    public void shape(){
        System.out.println("shapeDetails of Bike::::::::"+shapeDetails);
    }

}


class Car extends AbstractClass{
    private int modelNumber;
    private int shapeDetails;

    public Car(String className,int modelNumber,int shapeDetails) {
        super(className);
        this.modelNumber=modelNumber;
        this.shapeDetails = shapeDetails;
    }

    public void shape(){
        System.out.println("shapeDetails of Car::::::::"+shapeDetails);
    }

    public void  price() {
        System.out.println("shapeDetails of Car::::::::"+(modelNumber*20));
    }
}


class demo{
    public static void main(String[] args) {
        AbstractClass bike = new Bike("Bike",20,30);
        bike.shape();
        bike.price();
        AbstractClass Car = new Bike("Bike",200,300);
        Car.shape();
        Car.price();


        AbstractClass abstractClass = new AbstractClass("Class") {
            @Override
            public void shape() {
                System.out.println("Perform shape operation");
            }

            @Override
            public void price() {
                System.out.println("Perform Price operation");
            }
        };

        abstractClass.price();
        abstractClass.shape();

    }
}
