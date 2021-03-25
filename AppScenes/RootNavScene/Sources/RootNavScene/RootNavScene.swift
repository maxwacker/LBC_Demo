import GenRouting

public final class RootNavSceneFactory {
    public lazy var viewController: RootNavigatoring = { RootNavigator() as RootNavigatoring} ()
    public lazy var router: RootNavRouting = {
        let router = NavigationRouter()
        router._viewController = self.viewController
        return router as RootNavRouting
    }()
    
    public init() {}
    
}
