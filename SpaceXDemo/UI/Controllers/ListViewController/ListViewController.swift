//
//  ListViewController.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 24.11.2020.
//

import UIKit

class ListViewController: BaseViewController {

    // MARK: Components
    internal let cvSlider: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        return collectionView
    }()

    internal let sliderIndicator: UIPageControl = {
        let pc = UIPageControl(frame: .zero)
        pc.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        pc.pageIndicatorTintColor = .white
        pc.currentPageIndicatorTintColor = .black
        pc.hidesForSinglePage = true
        return pc
    }()

    internal let tableViewLaunches: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.bounces = true
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 8, bottom: 0, right: 8)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()

    // MARK: Vars
    var viewModel: ListViewModel!
    internal var sliderDataSource: HomeSliderDataSource? = nil
    internal var sliderTimer: Timer? = nil

    internal var listDataSource: TableViewGenericDataSource<LaunchesResponse, HomeListCell>? = nil
    internal var isNewDataLoading: Bool = false

    override func initialComponents() {
        self.view.backgroundColor = .white
        self.title = "SpaceX"
        self.addSubViews()
        self.setupConstraints()

        self.initHomeSlider()
        self.initListTableView()
    }

    override func registerEvents() {
        self.startSliderTimer()
        self.listenSliderDidScroll()

        self.listenListPagination()
        self.listenDidSelectListItem()
    }

    override func createdUIInitWithEvents() {
        self.observeAllApi()

        self.viewModel.fetchUpcomingLaunches()
    }

    private func fetchAllLaunches() {
        self.viewModel.fetchAllLaunches()
    }

    private func initHomeSlider() {
        sliderDataSource = HomeSliderDataSource()
        cvSlider.delegate = sliderDataSource
        cvSlider.dataSource = sliderDataSource
        cvSlider.registerCell(HomeSliderCell.self)
    }

    private func startSliderTimer() {
        self.sliderTimer?.invalidate()

        self.sliderTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            if self.sliderIndicator.currentPage >= self.viewModel.upcomingLaunchesCount() - 1 {
                self.sliderIndicator.currentPage = 0
            } else {
                self.sliderIndicator.currentPage += 1
            }
            let indexPath = IndexPath(item: self.sliderIndicator.currentPage, section: 0)
            self.cvSlider.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    private func listenSliderDidScroll() {
        sliderDataSource?.callbackScrollViewDidScroll = {
            let visibleRect = CGRect(origin: self.cvSlider.contentOffset, size: self.cvSlider.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = self.cvSlider.indexPathForItem(at: visiblePoint) {
                self.startSliderTimer()
                self.sliderIndicator.currentPage = visibleIndexPath.row
            }
        }
    }

    private func initListTableView() {
        self.listDataSource = TableViewGenericDataSource()
        self.tableViewLaunches.delegate = listDataSource
        self.tableViewLaunches.dataSource = listDataSource
        self.tableViewLaunches.registerCell(HomeListCell.self)
    }

    private func listenListPagination() {
        self.listDataSource?.callbackPagination = {
            if !self.isNewDataLoading {
                self.isNewDataLoading = true
                self.viewModel.allLaunchesOffset += self.viewModel.allLaunchesLimit
                self.showProgress()
                self.fetchAllLaunches()
            }
        }
    }

    private func listenDidSelectListItem() {
        self.listDataSource?.didSelectListener = { (item, indexPath) in
            if let flightNumber = item.flight_number {
                let detailVC = NavigateHelper.shared.createLaunchDetailViewController(
                    pageTitle: item.mission_name ?? "",
                    flightNumber: flightNumber,
                    imageUrl: item.rocket?.imageUrl // dummy content
                )
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }

}

// MARK: Observer APIs States
private extension ListViewController {

    private func observeAllApi() {
        self.observeUpcomingLaunchesState()
        self.observeAllLaunchesState()
    }

    func observeUpcomingLaunchesState() {
        observeAPIState(apiState: self.viewModel.upcomingLaunchesApiState,
                        callbackLoading: {
                            self.showProgress()
                        },
                        callbackSuccess: { content in
                            self.viewModel.upcomingLaunchesResponse = content
                            self.viewModel.processUpcomingLaunchesResponse()
                            self.handleHomeSliderByApiResult()

                            // fetch all launches
                            self.fetchAllLaunches()
                        },
                        callbackComplete: { isError in
                            if isError { // if there is any error
                                self.hideProgress()
                            }
                        })
    }

    private func handleHomeSliderByApiResult() {
        self.sliderDataSource?.items = self.viewModel.upcomingLaunchesResponse
        self.sliderIndicator.currentPage = 0
        self.sliderIndicator.numberOfPages = self.viewModel.upcomingLaunchesCount()
        self.cvSlider.reloadData()
    }

    func observeAllLaunchesState() {

        let customApiErrorHandler =
            CustomApiErrorHandler(viewController: self,
                                  callbackErrorUndefined: { errorDesc in
                                      // different error UI or
                                      // retry or
                                      // what else error handling
                                  })

        observeAPIState(apiState: self.viewModel.allLaunchesApiState,
                        apiErrorHandler: customApiErrorHandler,
                        callbackSuccess: { content in
                            if content.count > 0 {
                                var tempContent = content
                                self.viewModel.mainupulateLaunchesResponse(list: &tempContent)
                                self.handleAllLaunchesByApiResult(tempContent: tempContent)
                            } else {
                                self.isNewDataLoading = true // artık istek atılmayacak.
                                self.showSystemAlertMessage(title: "", message: "Tüm datalar listelendi.")
                            }

                        },
                        callbackComplete: { _ in
                            self.isNewDataLoading = false
                            self.hideProgress()
                        })
    }

    private func handleAllLaunchesByApiResult(tempContent: [LaunchesResponse]) {

        let itemsCounts = self.listDataSource?.items.count ?? 0
        self.listDataSource?.items.append(contentsOf: tempContent)

        self.tableViewLaunches.performBatchUpdates({

            let upCount = tempContent.count + self.viewModel.allLaunchesOffset
            let indexPaths = (itemsCounts..<upCount)
                .map({ IndexPath(row: $0, section: 0) })

            self.tableViewLaunches.insertRows(at: indexPaths, with: .bottom)
        }, completion: nil)
    }

}

