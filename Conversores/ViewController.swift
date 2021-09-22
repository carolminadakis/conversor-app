//
//  ViewController.swift
//  Conversores
//
//  Created by Ana Carolina Bernardes Minadakis on 16/09/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var btUnitOne: UIButton!
    @IBOutlet weak var btUnitTwo: UIButton!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var lbResultUnit: UILabel!
    @IBOutlet weak var lbUnit: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
    @IBAction func showNext(_ sender: UIButton) {
        switch lbUnit.text! {
            case "Temperatura":
                lbUnit.text = "Peso"    //muda o texto da tela de Temperatura, para Peso
                btUnitOne.setTitle("Kilograma", for: .normal)   //muda o texto do botão Celsius da tela para Kilograma
                btUnitTwo.setTitle("Libra", for: .normal)   //muda o texto do botão Farenheint da tela para Libra
            case "Peso":
                lbUnit.text = "Moeda"   //muda o texto da tela de Peso, para Moeda
                btUnitOne.setTitle("Real", for: .normal)
                btUnitTwo.setTitle("Dólar", for: .normal)
            case "Moeda":
                lbUnit.text = "Distância"   //muda o texto da tela de Moeda, para Distância
                btUnitOne.setTitle("Metro", for: .normal)
                btUnitTwo.setTitle("Kilômetro", for: .normal)
            default:
                lbUnit.text = "Temperatura" //caso nenhuma das escolhidas acima, apresenta Temperatura
                btUnitOne.setTitle("Celsius", for: .normal)
                btUnitTwo.setTitle("Farenheint", for: .normal)
        }
        convert(nil)
    }
    
    //Tanto botão da esquerda (Celsius), quanto da direita (Farenheint) chamam a mesma action convert,
    //não é necessário criar uma action para cada
    @IBAction func convert(_ sender: UIButton?) {
        if let sender = sender {
            //se o usuário clicar no botão da esquerda, o da direita ficará mais transparente, e vice versa
            if sender == btUnitOne {
                btUnitTwo.alpha = 0.5
            } else {
                btUnitOne.alpha = 0.5
            }
            //Fora essa alteração, o botão clicado ficará sem transparência
            sender.alpha = 1.0
        }
        
        switch lbUnit.text! {
            case "Temperatura":
                calcTemperature()
            case "Peso":
                calcWeight()
            case "Moeda":
                calcCurrency()
            default:
                calcDistance()
        }
        view.endEditing(true)
        let result = Double(lbResult.text!)!
        lbResult.text = String(format: "%.2f", result)
    }
    
    /*
    o guard let serve para assegurar de que não receberemos um Optional e sim um valor Double
    a diferença entre guard let e if let, é que o guard let, a variável com guard let, pode ser usada em todo o projeto
    enquando o if let só existe dentro do escopo do método que a chama
    */
    func calcTemperature() {
        guard let temperature = Double(tfValue.text!) else {return}
        //analiso se o botão da esquerda está selecionado
        if btUnitOne.alpha == 1.0 {
            //altero o texto abaixo do valor que foi convertido
            lbResultUnit.text = "Farenheint"
            //faço o cálculo de conversão
            lbResult.text = String((temperature * 1.8) + 32.0)
        } else {
            lbResultUnit.text = "Celsius"
            lbResult.text = String((temperature - 32.0) / 1.8)
        }
    }
    
    func calcWeight() {
        let pound = 2.2046
        guard let weight = Double(tfValue.text!) else {return}
        //analiso se o botão da esquerda está selecionado
        if btUnitOne.alpha == 1.0 {
            //altero o texto abaixo do valor que foi convertido
            lbResultUnit.text = "Libra"
            //faço o cálculo de conversão
            lbResult.text = String(weight / pound)
        } else {
            lbResultUnit.text = "Kilograma"
            lbResult.text = String(weight * pound)
        }
    }
    
    func calcCurrency() {
        let dolar = 5.34
        guard let currency = Double(tfValue.text!) else {return}
        //analiso se o botão da esquerda está selecionado
        if btUnitOne.alpha == 1.0 {
            //altero o texto abaixo do valor que foi convertido
            lbResultUnit.text = "Dólar"
            //faço o cálculo de conversão
            lbResult.text = String(currency / dolar)
        } else {
            lbResultUnit.text = "Real"
            lbResult.text = String(currency * dolar)
        }
    }
    
    func calcDistance() {
        let measure = 1000.0
        guard let distance = Double(tfValue.text!) else {return}
        //analiso se o botão da esquerda está selecionado
        if btUnitOne.alpha == 1.0 {
            //altero o texto abaixo do valor que foi convertido
            lbResultUnit.text = "Kilômetro"
            //faço o cálculo de conversão
            lbResult.text = String(distance / measure)
        } else {
            lbResultUnit.text = "Metros"
            lbResult.text = String(distance * measure)
        }
    }
}

