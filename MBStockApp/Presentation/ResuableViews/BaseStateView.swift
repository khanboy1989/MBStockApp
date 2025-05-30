//
//  BaseStateView.swift
//  MBStockApp
//
//  Created by Serhan Khan on 29/05/2025.
//
import SwiftUI

/// Handle changes in the state of the given [ViewModel] and display the appropriate view.
struct BaseStateView<VM, SuccessView, NoItemsView, ErrorView, LoadingView, RefreshingView>: View
where VM: ViewModel, SuccessView: View, NoItemsView: View, ErrorView: View,
      LoadingView: View, RefreshingView: View {
    
    @ObservedObject var viewModel: VM
    let successView: () -> SuccessView
    let emptyView: () -> NoItemsView
    let errorView: (String) -> ErrorView
    let loadingView: () -> LoadingView
    let refreshingView: () -> RefreshingView
    
    /// Initialize the view with the given [ViewModel] and views to display in each state.
    ///
    /// - Parameters:
    ///  - viewModel: The [ViewModel] to observe its state.
    ///  - successView: The view to display when the state is [ViewState.success].
    ///  - emptyView: The view to display when the state is [ViewState.empty].
    ///  - errorView: The view to display when the state is [ViewState.error].
    ///  - loadingView: The view to display when the state is [ViewState.loading].
    ///  - refreshView : The view to display when the state is [ViewState.refreshing]
    ///
    ///  - Note: The default value for each view is nil, so you have to provide at least the successView.
    init(viewModel: VM,
         @ViewBuilder successView: @escaping () -> SuccessView,
         @ViewBuilder emptyView: @escaping () -> NoItemsView
         = { MessageView(message: "noDataFound".localized()) },
         @ViewBuilder errorView: @escaping (String) -> ErrorView
         = {MessageView(message: $0)},
         @ViewBuilder loadingView: @escaping () -> LoadingView
         = { ProgressView() },
         @ViewBuilder
         refreshingView: @escaping () -> RefreshingView = {ProgressView()}) {
        self.viewModel = viewModel
        self.successView = successView
        self.emptyView = emptyView
        self.errorView = errorView
        self.loadingView = loadingView
        self.refreshingView = refreshingView
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .initial,
                    .loading:
                loadingView()
            case .error(let errorMessage):
                errorView(errorMessage)
            case .empty:
                emptyView()
            case .success:
                successView()
            case .refreshing:
                VStack {
                    refreshingView()
                        .transition(.move(edge: .top).combined(with: .opacity))
                    successView()
                }.animation(.easeInOut(duration: 0.2), value: viewModel.state)
            }
        }
    }
}
