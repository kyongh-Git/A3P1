//
//  LogoViewController.swift
//  A3_P1_Kim_YongHwan
//
//  Created by YongHwan Kim on 9/28/19.
//  Copyright © 2019 YongHwan Kim. All rights reserved.
//

import UIKit

class LogoViewController: UIViewController {

    @IBOutlet weak var NavigationBarLOGO: UINavigationItem!
    @IBOutlet weak var LogoImage: UIImageView!
    @IBOutlet weak var LogoLabel: UILabel!
    @IBAction func LogoToMain(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func unwindToLogo(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.isNavigationBarHidden = true
        //self.navigationController?.isToolbareHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
