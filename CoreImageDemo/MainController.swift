//
//  MainController.swift
//  CoreImageDemo
//
//  Created by FFIB on 2018/7/30.
//  Copyright © 2018 FFIB. All rights reserved.
//

import UIKit

class MainController: UITableViewController {

    var controllers = [UIViewController]()
    var functions = ["MirrorX", "Vignette", ""]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        cell.textLabel?.text = functions[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
