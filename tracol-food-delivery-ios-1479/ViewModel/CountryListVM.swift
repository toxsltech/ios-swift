//
/**
 *
 *@copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *@author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import UIKit

class CountryListVM: NSObject {
    //MARK:- Variables
    var countryListArr = [CountryListModel]()
    var cityListArr = [CountryListModel]()
    let objCountryListModel = CountryListModel()
    var selectValue = -1
    var selectedId = Int()
    var totalPage  = 0
    var currentPage  = 0
    var totalPageCities  = 0
    var currentPageCities  = 0
    var searchStrVal = String()
    
    //MARK:- Get Country List Api
    func getCountryListApi(_  completion:@escaping() -> Void )  {
        let result = GetFeaturesService.countryList(page: currentPage, searchText: searchStrVal).task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    
                    if self.currentPage == 0 {
                        self.countryListArr = []
                    }
                    if let dictMeta = data["_meta"] as? NSDictionary {
                        self.totalPage  = dictMeta["pageCount"] as! Int
                    }
                    if let listArr = data["list"] as? NSArray{
                        for dict in listArr{
                            if let detialDict = dict as? NSDictionary{
                                let objCountryListModel = CountryListModel()
                                objCountryListModel.setDetail(detialDict: detialDict)
                                self.countryListArr.append(objCountryListModel)
                            }
                        }
                        completion()
                    }
                }
            }
        }
    }
    //MARK:- Get City List Api
    func getCityListApi(_ id: Int, completion:@escaping() -> Void )  {
        let result = GetFeaturesService.citiesList(countryId: id, page: currentPageCities, searchText: searchStrVal).task
        result.responseJSON { (resData) in
            WebServiceProxy.shared.handelResponseStauts(response: resData) { (response) in
                if let data = response!.data{
                    if self.currentPageCities == 0 {
                        self.cityListArr = []
                    }
                    if let dictMeta = data["_meta"] as? NSDictionary {
                        self.totalPageCities  = dictMeta["pageCount"] as! Int
                    }
                    if let listArr = data["list"] as? NSArray{
                        for dict in listArr{
                            if let detialDict = dict as? NSDictionary{
                                let objCityListModel = CountryListModel()
                                objCityListModel.setDetail(detialDict: detialDict)
                                self.cityListArr.append(objCityListModel)
                            }
                        }
                        completion()
                    }
                }
            }
        }
    }
}
//MARK:- UITableView Delegate Methods
extension CountryListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.title == "Country" ? objCountryListVM.countryListArr.count : objCountryListVM.cityListArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryListTVC.className) as! CountryListTVC
        if  self.title == "Country" {
            let dict = objCountryListVM.countryListArr[indexPath.row]
            cell.lblCountryName.text = dict.name
        } else {
            let dict = objCountryListVM.cityListArr[indexPath.row]
            cell.lblCountryName.text = dict.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.title == "Country" {
            if indexPath.row == objCountryListVM.countryListArr.count-1 {
                if objCountryListVM.totalPage > objCountryListVM.currentPage+1 {
                    objCountryListVM.currentPage += 1
                    objCountryListVM.getCountryListApi() {
                        DispatchQueue.main.async {
                            self.tblVwCountryList.reloadData()
                        }
                    }
                }
            }
        }else{
            if indexPath.row == objCountryListVM.cityListArr.count-1 {
                if objCountryListVM.totalPageCities > objCountryListVM.currentPage+1 {
                    objCountryListVM.currentPageCities += 1
                    objCountryListVM.getCityListApi(objCountryListVM.selectedId) {
                        DispatchQueue.main.async {
                            self.tblVwCountryList.reloadData()
                        }
                    }
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  self.title == "Country" {
            let dict = objCountryListVM.countryListArr[indexPath.row]
            guard let finalComp = complition else {
                return
            }
            finalComp(dict.name, dict.id)
            dismiss(animated: true)
        } else {
            let dict = objCountryListVM.cityListArr[indexPath.row]
            guard let finalComp = complition else {
                return
            }
            finalComp(dict.name, dict.id)
            dismiss(animated: true)
        }
    }
}
extension CountryListVC: UITextFieldDelegate {
    //MARK:- Textfield delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if  self.title == "Country" {
            if txtFldSearch.text! != "" {
                view.endEditing(true)
                let urlString = self.txtFldSearch.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                objCountryListVM.searchStrVal = urlString!
                objCountryListVM.getCountryListApi() {
                    DispatchQueue.main.async {
                        self.tblVwCountryList.reloadData()
                    }
                }
            }
        }else{
            if txtFldSearch.text! != "" {
                view.endEditing(true)
                let urlString = self.txtFldSearch.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                objCountryListVM.searchStrVal = urlString!
                objCountryListVM.getCityListApi(objCountryListVM.selectedId) {
                    DispatchQueue.main.async {
                        self.tblVwCountryList.reloadData()
                    }
                }
            }
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        objCountryListVM.searchStrVal = ""
        txtFldSearch.text = ""
        if  self.title == "Country" {
            objCountryListVM.getCountryListApi() {
                DispatchQueue.main.async {
                    self.tblVwCountryList.reloadData()
                }
            }
        }else{
            objCountryListVM.getCityListApi(objCountryListVM.selectedId) {
                DispatchQueue.main.async {
                    self.tblVwCountryList.reloadData()
                }
            }
        }
        return false
    }
}
