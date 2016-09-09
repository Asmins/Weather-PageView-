import UIKit

class MoreDetailViewController: UIViewController {
    
    var viewModel:MoreDetailViewModel!
    
    @IBOutlet weak var labelForWindSpeed: UILabel!
    @IBOutlet weak var labelForHumidity: UILabel!
    @IBOutlet weak var labelForUvIndex: UILabel!
    @IBOutlet weak var labelForHighTemperature: UILabel!
    @IBOutlet weak var labelForLowTemperature: UILabel!
    @IBOutlet weak var labelForTypeWeather: UILabel!
    @IBOutlet weak var labelForMonth: UILabel!
    @IBOutlet weak var labelForDate: UILabel!
    @IBOutlet weak var labelForWeekDay: UILabel!
    
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        labelForTypeWeather.text = viewModel.typeWeather
        labelForWindSpeed.text = viewModel.windSpeed
        labelForWeekDay.text = viewModel.weekDay
        labelForDate.text = viewModel.date
        labelForMonth.text = viewModel.nameMonth
        labelForUvIndex.text = viewModel.uvIndex
        labelForHumidity.text = viewModel.humidity
        labelForLowTemperature.text = viewModel.lowTemperature
        labelForHighTemperature.text = viewModel.highTemperature
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}