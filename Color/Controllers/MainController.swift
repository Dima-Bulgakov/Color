//
//  ViewController.swift
//  Color
//
//  Created by Dima on 01.06.2023.
//

import UIKit
import CoreData

class MainController: UIViewController {

    // MARK: - Properties
    let colorChoiceView = ColorChoiceView()
    let colorListView = ColorListView()
    var colorModel: ColorModel!
    var cellData: [ColorEntity] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setFirstColors()
        mainConfig()
        setupConstraints()
        colorListView.tableView.delegate = self
        colorListView.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequst: NSFetchRequest<ColorEntity> = ColorEntity.fetchRequest()
        
        do {
            cellData = try context.fetch(fetchRequst)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    // MARK: - Methods
    private func mainConfig() {
        let backgroundImageView = UIImageView(image: Helper.Image.backgroundImage)
        backgroundImageView.frame = view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        view.addMySubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        view.addMySubview(colorChoiceView)
        view.addMySubview(colorListView)
        
        colorChoiceView.redSlider.addTarget(self, action: #selector(redSliderChange), for: .valueChanged)
        colorChoiceView.greenSlider.addTarget(self, action: #selector(greenSliderChange), for: .valueChanged)
        colorChoiceView.blueSlider.addTarget(self, action: #selector(blueSliderChange), for: .valueChanged)
        
        colorChoiceView.addColorButton.addTarget(self, action: #selector(addColorButtonAction), for: .touchUpInside)
    }
    
    func setFirstColors() {
        colorModel = ColorModel(red: CGFloat(colorChoiceView.redSlider.value),
                                green: CGFloat(colorChoiceView.greenSlider.value),
                                blue: CGFloat(colorChoiceView.blueSlider.value))
        colorChoiceView.resultColorView.backgroundColor = colorModel.getColor()
    }

    
    @objc func redSliderChange() {
        colorModel.setRed(red: colorChoiceView.redSlider.value)
        colorChoiceView.numRedLabel.text = String(format: "%.0f", colorChoiceView.redSlider.value)
        colorChoiceView.resultColorView.backgroundColor = colorModel.getColor()
    }
    
    @objc func greenSliderChange() {
        colorModel.setGreen(green: colorChoiceView.greenSlider.value)
        colorChoiceView.numGreenLabel.text = String(format: "%.0f", colorChoiceView.greenSlider.value)
        colorChoiceView.resultColorView.backgroundColor = colorModel.getColor()
    }
    
    @objc func blueSliderChange() {
        colorModel.setBlue(blue: colorChoiceView.blueSlider.value)
        colorChoiceView.numBlueLabel.text = String(format: "%.0f", colorChoiceView.blueSlider.value)
        colorChoiceView.resultColorView.backgroundColor = colorModel.getColor()
    }
    
    @objc func addColorButtonAction() {
        colorModel.setRed(red: colorChoiceView.redSlider.value)
        colorModel.setGreen(green: colorChoiceView.greenSlider.value)
        colorModel.setBlue(blue: colorChoiceView.blueSlider.value)
        
        guard let hex = hexFromColor(colorModel.getColor()) else { return }
        saveData(data: hex)
        colorListView.tableView.reloadData()
    }
    
    // CoreData
    func saveData(data: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        guard let entity = NSEntityDescription.entity(forEntityName: "ColorEntity", in: context) else {
            print("Failed to create entity description")
            return

        }

        let dataObject = ColorEntity(entity: entity, insertInto: context)
        dataObject.color = data

        do {
            try context.save()
            cellData.append(dataObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // Hex to UIColor
    func colorFromHex(_ hex: String) -> UIColor? {
        var hexString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        if hexString.count != 6 {
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func hexFromColor(_ color: UIColor) -> String? {
        guard let components = color.cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        
        let hexString = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(red * 255)),
            lroundf(Float(green * 255)),
            lroundf(Float(blue * 255))
        )
        return hexString
    }
}

// MARK: - Extensions
extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data = cellData[indexPath.row]
        let hexToColor = colorFromHex(data.color ?? "")
        cell.backgroundColor = hexToColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let data = cellData[indexPath.row]
            context.delete(data)
            
            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            tableView.reloadData()
            
            cellData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let selectedColor = cellData[indexPath.row]
        let color = selectedColor.color ?? ""
        let hexToColor = colorFromHex(color)
        let vc = ColorController()
        vc.view.backgroundColor = hexToColor
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            colorChoiceView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            colorChoiceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            colorChoiceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            colorChoiceView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            colorListView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            colorListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            colorListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            colorListView.bottomAnchor.constraint(equalTo: colorChoiceView.topAnchor, constant: -30)
        ])
    }
}