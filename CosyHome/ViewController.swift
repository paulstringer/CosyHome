import UIKit

class ViewController: UIViewController, TemperatureGroupView {
    
    @IBOutlet var temperatureLabels: [UILabel]!
    @IBOutlet var steppers: [UIStepper]!
    @IBOutlet var labels: [UILabel]!
    
    var input: TemperatureInteractorInput? {
        didSet {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        input?.request(.load)
    }

    //MARK: Temperature Group View
    
    var low: TemperatureGroupItem? {
        
        didSet {
            
            configureTemperatureGroupItemUI(low)
            
        }
    }
    
    var middle: TemperatureGroupItem? {
        
        didSet {
            
            configureTemperatureGroupItemUI(middle)
            
        }
    }
    
    var high: TemperatureGroupItem? {
        
        didSet {
            
            configureTemperatureGroupItemUI(high)
        }
    }
    
    //MARK: IBActions
    
    @IBAction func adjustLow(_ sender: UIStepper) {
        
        input?.request(.adjustLow(temperature: sender.value))
        
    }
    
    
    @IBAction func adjustMiddle(_ sender: UIStepper) {
        
        input?.request(.adjustMiddle(temperature: sender.value))
        
    }
    
    @IBAction func adjustHigh(_ sender: UIStepper) {
        
        input?.request(.adjustHigh(temperature: sender.value))
        
    }
    
    //MARK: Private
    
    fileprivate func configureTemperatureGroupItemUI(_ item: TemperatureGroupItem?) {
        
        guard let item = item, let index = [low, middle, high].index(where: { (x) -> Bool in
            return x == item
        }) else {
            return
        }
        
        configureComponentsWithItem(item, atIndex: index)
        
    }
    
    fileprivate func configureComponentsWithItem(_ item: TemperatureGroupItem, atIndex index: Int){
        
        
        let label = labels[index]
        label.text = NSLocalizedString(item.name, comment: "")
        
        let temperatureLabel = temperatureLabels[index]
        temperatureLabel.text = item.temp
        
        let stepper = steppers[index]
        stepper.minimumValue = item.minimum
        stepper.maximumValue = item.maximum
        stepper.value = Double(item.temp)!
    }
}

