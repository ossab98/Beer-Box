
//
//  BeerBoxController.swift
//  Birreria
//
//  Created by Ossama Abdelwahab on 26/05/21.
//

import UIKit

class BeerBoxController: UIViewController, UITextFieldDelegate {
    
    // MARK:- Outlets
    // TableView
    @IBOutlet weak var tableView: UITableView!
    // CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    // Search View
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchField: UITextField!
    
    
    // MARK: - Properties / Models
    let networkHandler = NetworkHandler()
    var beerArray: [BeerBoxElement] = []
    var offers: [OfferModel] = []
    
    // Pagination variables
    var page: Int = 1
    var per_page: Int = 20
    var isLimit: Bool = false
    
    // refresh
    var refreshControl = UIRefreshControl()
    
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        appendDemoOffers()
        getBeers()
        setUpView()
    }
    
    // viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set Navigation Title & backgroundColor
        navigationItem.title = "Beer Box"
        navigationController?.navigationBar.backgroundColor = Config.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: semiBold(Config.title),
        NSAttributedString.Key.foregroundColor : Config.white!]
        
        
        // Poll to refresh TableView and get new data
        refreshTableView()
    }
    
    // didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // UICollectionView allow autolayout dynamic height and Width
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            var itemWidth: CGFloat
            if offers.count > 1 {
                itemWidth = view.bounds.width - 60
                collectionView.isScrollEnabled = true
            }else{
                itemWidth = view.bounds.width - 40
                collectionView.isScrollEnabled = false
            }
            
            let itemHeight = layout.itemSize.height
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
    }
    
}


//MARK:- extension UITableViewDelegate && UITableViewDataSource
extension BeerBoxController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    // numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerArraySorted().count
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerBoxCell", for: indexPath) as! BeerBoxCell
        cell.setUpCell(beerArraySorted()[indexPath.row])
        return cell
    }
    
    // didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        
        // Show Popup BeerBoxDetail
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "beerBoxDetailPopupController") as! BeerBoxDetailPopupController
        popOverVC.entity = beerArraySorted()[indexPath.row]
        self.present(popOverVC, animated: true)
        
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK:- Pagination to get new data
    
    // Hide NavigationBar when scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    // scrollViewDidEndDragging
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        if !decelerate{
            scrolledToBottom(scrollView)
        }
    }
    
    // scrolledToBottom
    private func scrolledToBottom(_ scrollview:UIScrollView){
        let bottomEdge = scrollview.contentOffset.y + scrollview.frame.size.height
        if bottomEdge >= scrollview.contentSize.height{
            loadMoreData()
        }
    }
    
    // scrollViewDidEndDecelerating
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        scrolledToBottom(scrollView)
    }
    
    // Func to get new items when scrolling
    public func loadMoreData() {
        if isLimit == true {
            return
        }else{
            page = page + 1
            self.getBeers()
        }
    }
    
}


//MARK:- extension UICollectionViewDelegate && UICollectionViewDataSource
extension BeerBoxController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell", for: indexPath) as! OfferCell
        cell.setUpCell(offers[indexPath.row])
        return cell
    }
    
    //didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        self.alert(title: offers[indexPath.row].title, message: "Offer expires on: \(offers[indexPath.row].expirationDate)", preferredStyle: .alert){_ in}
    }
    
}


// MARK: - Func Helper
extension BeerBoxController {
    
    // Reload the tableView
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.updateEmptyState(rowsCount: self.beerArraySorted().count, emptyMessage: "No data found!")
            self.tableView.reloadData()
        }
    }
    
    // refresh
    func refreshTableView(){
        refreshControl.attributedTitle = NSAttributedString(string: "Reload",
        attributes: [NSAttributedString.Key.foregroundColor: Config.orange!])
        refreshControl.tintColor = Config.orange
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    // Poll to refresh
    @objc func refresh(_ sender: AnyObject) {
        // Remove all data
        self.beerArray.removeAll()
        // Reload View
        self.reloadTableView()
        // Rest Pagination
        self.page = 1
        self.isLimit = false
        // Get new data
        self.getBeers()
        // End Refreshing
        refreshControl.endRefreshing()
    }
    
    // Call API to get Data
    func getBeers(){
        DispatchQueue.main.async {
            if Connectivity.isConnectedToInternet() {
                self.callAPI()
            }else{
                self.alert(title: "", message: "Not connected to the internet. Please check your internet connection.", preferredStyle: .alert) {_ in
                    self.reloadTableView()
                }
            }
        }
    }
    
    func callAPI(){
        
        DispatchQueue.main.async {
            // Strat animation
            self.view.startLoading()
        }
        
        // call API
        let path = "?page=\(self.page)&per_page=\(per_page)"
        networkHandler.postData(urlPath: "beers" + path, method: .get, with: [BeerBoxElement].self , parameters: .none, returnWithData: {[weak self](response) in
            
            DispatchQueue.main.async {
                // Stop animation
                self?.view.stopLoading()
            }
            
            guard let self = self , let data = response else {return}
            
            if data.count < self.per_page {
                // There are no other data! Stop pagination
                self.isLimit = true
            }else{
                // Append new data in beerArray
                self.beerArray.append(contentsOf: data)
            }
            
            // Reload View
            self.reloadTableView()
            
        }, returnError: {[weak self](error) in
            self?.view.stopLoading()
            // Show error message
            self?.alert(title: "Error", message: error?.localizedDescription ?? "Ops, something went wrong try again later.", preferredStyle: .alert, completion:{_ in})
        })
    }
    
}


//MARK:- Search
extension BeerBoxController {
    
    // Function to filter beerArray by "name", "description", "tagline"
    func beerArraySorted() -> [BeerBoxElement] {
        if searchField.text == "" {
            return beerArray
        }else{
            return beerArray.filter({
                $0.name?.uppercased().contains(searchField.text!.uppercased()) ?? false ||
                $0.descriptionField?.uppercased().contains(searchField.text!.uppercased()) != false ||
                $0.tagline?.uppercased().contains(searchField.text!.uppercased()) != false
            })
        }
    }
    
    // Reload tableView when writing
    @IBAction func searchTextField(_ sender: UITextField) {
        reloadTableView()
    }
    
    // Reload tableView when cancell all text
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchField.text = ""
        reloadTableView()
        return false
    }
    
    // Reload tableView when click "Search" on Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchField.returnKeyType = .search
        reloadTableView()
        return true
    }
    
    // textFieldDidBeginEditing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        reloadTableView()
    }
    
}


// MARK:- Func SetUpView
extension BeerBoxController {
    
    func setUpView(){
        
        // Set backgroundColor View
        view.backgroundColor = Config.darkBlue
        
        // Set TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        // Set CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        // Set Search View
        searchView.backgroundColor = Config.darkGray
        searchView.layer.cornerRadius = Config.cornerRadius
        searchView.dropShadow()
        
        // Set Search image
        searchImg.image = UIImage(named: "search")
        searchImg.contentMode = .scaleAspectFill
        
        // Set Search Field
        searchField.delegate = self
        searchField.textColor = Config.gray
        searchField.font = medium(Config.body)
        searchField.attributedPlaceholder = NSAttributedString(string: "Search",
        attributes: [NSAttributedString.Key.foregroundColor: Config.gray ?? .gray ])
        
    }
    
    // append demo data in offers collectionView.
    func appendDemoOffers(){
        offers.append(OfferModel(id: 1, title: "Weekend Offers", caption: "Free shipping on orders over 60€", img: "imgOffer", expirationDate: "23/09/2021"))
    }
    
}
