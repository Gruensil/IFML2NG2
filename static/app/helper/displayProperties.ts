export class DisplayProperties {
    private type: string;
    private role: string;

    // [{path:<path>,text:<link text>}]
    private navigation: any;

    //General Layout
    public headerBarClass: string;
    public routerOutletClass: string;
    public hideOnMobile: string;
    public hideOnDesktop: string;

    //tables
    public tableClass: string;

    //navigation
    public navbarContainerClass: string;
    public navbarWrapperClass: string;
    public navbarHeaderClass: string;
    public navbarCollapseClass: string;
    public navbarItemListClass: string;

    //search
    public searchInputGroupClass: string;

    //boolean
    public isMobile: boolean;
    public isAdvancedUser: boolean;

    constructor()
    {
        this.type = '';
        this.role = '';

        this.clearNavigation();
        
        //General Layout
        this.headerBarClass = '';
        this.routerOutletClass = '';
        this.hideOnMobile = '';
        this.hideOnDesktop = '';

        //tables
        this.tableClass = 'table table-striped table-hover table-condensed'

        //navigation
        this.navbarContainerClass = '';
        this.navbarWrapperClass = '';
        this.navbarHeaderClass = '';
        this.navbarCollapseClass = '';
        this.navbarItemListClass = '';

        //search
        this.searchInputGroupClass = '';

        //boolean
        this.isMobile = false;
        this.isAdvancedUser = false;

    };

    public setType(v: string){
        this.type = v;
    }

    public setRole(v:string){
        this.role = v;
    }

    public setTableClass(v:string){
        this.tableClass = v;
    }

    // set navigation for user
    public setNavigation(nav: Object[]){
        this.navigation = nav;
    }

    // Get navigation for user
    public getNavigation(){
        return this.navigation;
    }

    // clear navigation object
    public clearNavigation(){
        this.navigation = [];
    }

    // push new Navigation item to navigation
    public pushNavigation(newItem:Object){
        return this.navigation.push(newItem);
    }

    // remove Navigation path from navigation
    public removeNavigationPath(path:String){
        if(this.navigation != undefined){
            this.navigation = this.navigation.filter(function(element){
                return element.path !== path;
            });
        };
    }
}
