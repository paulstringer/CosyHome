
import UIKit

class ViewController: UIViewController, TemperatureGroupView {
    
    @IBOutlet var temperatureLabels: [UILabel]!
    @IBOutlet var steppers: [UIStepper]!
    
    var input: TemperatureInteractorInput? {
        didSet {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        input?.request(.load)
    }

    //MARK: Temperature Group View
    
    var slumber: TemperatureGroupItem? {
        
        didSet {
            
            configureTemperatureGroupItemUI(slumber)
            
        }
    }
    
    var comfy: TemperatureGroupItem? {
        
        didSet {
            
            configureTemperatureGroupItemUI(comfy)
            
        }
    }
    
    var cosy: TemperatureGroupItem? {
        
        didSet {
            
            configureTemperatureGroupItemUI(cosy)
        }
    }
    
    //MARK: IBActions
    
    @IBAction func adjustSlumber(sender: UIStepper) {
        
        input?.request(.adjustSlumber(temperature: sender.value))
        
    }
    
    
    @IBAction func adjustComfy(sender: UIStepper) {
        
        input?.request(.adjustComfy(temperature: sender.value))
        
    }
    
    @IBAction func adjustCosy(sender: UIStepper) {
        
        input?.request(.adjustCosy(temperature: sender.value))
        
    }
    
    //MARK: Private
    
    private func configureTemperatureGroupItemUI(item: TemperatureGroupItem?) {
        
        guard let item = item, let index = [slumber, comfy, cosy].indexOf({ (x) -> Bool in
            return x == item
        }) else {
            return
        }
        
        configureComponentsWithItem(item, atIndex: index)
        
    }
    
    private func configureComponentsWithItem(item: TemperatureGroupItem, atIndex index: Int){
        
        let label = temperatureLabels[index]
        label.text = item.temp
        
        let stepper = steppers[index]
        stepper.minimumValue = item.minimum
        stepper.maximumValue = item.maximum
        stepper.value = Double(item.temp)!
    }
}

