import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener, CardOnFileDashboardListener, AddPaymentMethodListener {
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    private let superPayDashboardBuildable: SuperPayDashboardBuildable
    private var superPayRouting: Routing?
    
    private let cardOnFileDashboardBuildable: CardOnFileDashboardBuildable
    private var cardOnFileRouting: Routing?
    
    private let addPaymentMethodBuildable: AddPaymentMethodBuildable
    private var addPaymentMethodRouting: Routing?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: FinanceHomeInteractable,
         viewController: FinanceHomeViewControllable,
         superPayDashboardBuildable: SuperPayDashboardBuildable,
         cardOnFileDashboardBuilable: CardOnFileDashboardBuildable,
         addPaymentMethodBuildable: AddPaymentMethodBuildable) {
        self.superPayDashboardBuildable = superPayDashboardBuildable
        self.cardOnFileDashboardBuildable = cardOnFileDashboardBuilable
        self.addPaymentMethodBuildable = addPaymentMethodBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSuperPayDashboard() {
        if superPayRouting != nil { return }
        
        let router = superPayDashboardBuildable.build(withListener: interactor)
        
        let dashboard = router.viewControllable
        viewController.addDashboard(dashboard)
        
        self.superPayRouting = router
        attachChild(router)
    }
    
    func attachCardOnFileDashboard() {
        if cardOnFileRouting != nil {
            return
        }
        
        let router = cardOnFileDashboardBuildable.build(withListener: interactor)
        let dashboard = router.viewControllable
        viewController.addDashboard(dashboard)
        self.cardOnFileRouting = router
        attachChild(router)
    }
    
    func attachAddPaymentMethod() {
        if addPaymentMethodRouting != nil {
            return
        }
        
        let router = addPaymentMethodBuildable.build(withListener: interactor)
        let navigation = NavigationControllerable(root: router.viewControllable)
        navigation.navigationController.presentationController?.delegate = interactor.presentationDelegateProxy
        viewControllable.present(navigation, animated: true, completion: nil)
        
        addPaymentMethodRouting = router
        attachChild(router)
    }
    
    func detachAddPaymentMethod() {
        guard let router = addPaymentMethodRouting else { return }
        
        viewControllable.dismiss(completion: nil)
        detachChild(router)
        addPaymentMethodRouting = nil
    }
}
