//
//  StatsView.swift
//  StatsData
//
//  Created by Manjula Pajaniraja on 02/03/21.
//

import UIKit

public class StatsView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var lowRangeLabel: UILabel!
    @IBOutlet var highRangeLabel: UILabel!
    @IBOutlet var userStatLabel: UILabel!
    @IBOutlet var rangeDistributionTableView: UITableView!
    @IBOutlet weak var updatedDateLabel: UILabel!
    
    var userStatsViewModel = UserStatsViewModel()
    
    public init(withData: Data) {
        super.init(frame: CGRect.zero)
        loadxib()
        setupTableView()
        bindData()
        DispatchQueue.global(qos: .userInteractive).async {
            self.userStatsViewModel.createModel(fromData: withData)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadxib()
    }
    
    private func loadxib() {
        
        let bundlePath = Bundle.main.path(forResource: "StatsViewsBundle", ofType: "bundle")!
        let bundle = Bundle(path: bundlePath)
        let nib = UINib(nibName: "StatsView", bundle: bundle)
        
        nib.instantiate(withOwner: self, options: nil)
        
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func setupTableView() {
        rangeDistributionTableView.delegate = self
        rangeDistributionTableView.dataSource = self
        let bundlePath = Bundle.main.path(forResource: "StatsViewsBundle", ofType: "bundle")!
        let bundle = Bundle(path: bundlePath)
        let nib = UINib(nibName: "RangeRepresentationCell", bundle: bundle)
        rangeDistributionTableView.register(nib, forCellReuseIdentifier: RangeRepresentationCell.reuseIdentifierId)
    }
    
    func setupData() {
        if let high = self.userStatsViewModel.userStatsData.value?.highRange, let low = self.userStatsViewModel.userStatsData.value?.lowRange, let userDataRange = self.userStatsViewModel.userStatsData.value?.userRangeValue {
            progressBar.progress = Float(Double(userDataRange)/Double(high)) 
            lowRangeLabel.text = String(low)
            highRangeLabel.text = String(high)
            userStatLabel.text = String(userDataRange)
        }
        updatedDateLabel.text = "As of " + (self.userStatsViewModel.userStatsData.value?.date ?? "")
        self.rangeDistributionTableView.reloadData()
    }
    
    func bindData() {
        self.userStatsViewModel.userStatsData.bind(observer: { playerData in
            DispatchQueue.main.async {
                self.setupData()
            }
        })
    }
    
    public func updateView(with data:Data) {
        userStatsViewModel.createModel(fromData: data)
    }
    
}

extension StatsView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userStatsViewModel.userStatsData.value?.rangeDetails?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RangeRepresentationCell.reuseIdentifierId) as? RangeRepresentationCell {
            if let rangeData = self.userStatsViewModel.userStatsData.value?.rangeDetails?[indexPath.row] {
                cell.setupData(details: rangeData)
                if userStatsViewModel.isUserRange(rangeDetails: rangeData) {
                    cell.enableUserRange(range:self.userStatsViewModel.userStatsData.value?.userRangeValue ?? 0)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Where you stand?"
    }
}
