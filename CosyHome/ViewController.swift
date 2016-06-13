import UIKit

class ViewController: UIViewController, TemperatureGroupView {
    
    @IBOutlet var temperatureLabels: [UILabel]!
    
    var input: TemperatureInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        input?.request(.load)
    }

    //MARK: Temperature Group View
    
    var slumber: TemperatureGroupItem? {
        didSet {
            let label = temperatureLabels[0]
            label.text = slumber?.temp
        }
    }
    var comfy: TemperatureGroupItem? {
        didSet {
            let label = temperatureLabels[1]
            label.text = comfy?.temp
        }
    }
    var cosy: TemperatureGroupItem? {
        didSet {
            let label = temperatureLabels[2]
            label.text = cosy?.temp
        }
    }
    
    //MARK: IBActions
    
    @IBAction func adjustSlumber(sender: AnyObject) {
        
        input?.request(.adjustSlumber(temperature: 0.0))
        
    }
    
    
}

