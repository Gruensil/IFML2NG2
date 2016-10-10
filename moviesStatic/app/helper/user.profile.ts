// user context
export class UserProfile{
    private role: string;
    private isAdmin: boolean;
    private weakVision: boolean;
    private computerSelfEfficiacy: string;
    private language: string;

    private roleChecked: boolean;
    private langChecked: boolean;
    private adminChecked: boolean;
    private weakVisionChecked: boolean;
    private computerSelfEfficiacyChecked: boolean;

    constructor(r:string,w:boolean,c:string)
    {
        this.role = r;
        this.weakVision = w;
        this.computerSelfEfficiacy = c;
        this.isAdmin = false;
        
        this.language = 'enus';

        this.setAdminChecked(false);
        this.setLangChecked(false);
        this.setRoleChecked(false);
        this.setWeakVisionChecked(false);
        this.setComputerSelfEfficiacyChecked(false);
    };

    // Set role of user
    public setUserRole(role: string){
        this.role = role;
        this.setRoleChecked(false);
    };

    // True if user has weak eyesight, false otherwise
    public setWeakVision(hasWeakVision: boolean){
        this.weakVision = hasWeakVision;
        this.setWeakVisionChecked(false);
    };

    // True if user has high computer self-efficiacy, false otherwise
    public setComputerSelfEfficiacy(computerSelfEfficiacy: string){
        this.computerSelfEfficiacy = computerSelfEfficiacy;
        this.setComputerSelfEfficiacyChecked(false);
    };

    // True if user has admin privileges
    public setIsAdmin(v: boolean){
        this.isAdmin = v;
        this.setAdminChecked(false);
    }

    // Set key of user language
    public setLanguage(v: string){
        this.language = v;
        this.setAdminChecked(false);
    }

    // Get role of user
    public getUserRole(): string{
        return this.role;
    };

    // Get if user has weak vision
    public hasWeakVision(): boolean{
        return this.weakVision;
    };

    // Get if user has admin rights
    public getIsAdmin(): boolean{
        return this.isAdmin;
    }

    // Get if user has high computer self-efficiacy
    public hasHighComputerSelfEfficiacy(): string{
        return this.computerSelfEfficiacy;
    };
    
    // Get language key
    public getLanguage(): string{
        return this.language;
    }

    // Getters and Setters for flags that indicate if rule was already fired once
    public setRoleChecked(v: boolean){
        this.roleChecked = v;
    };
    public setWeakVisionChecked(v: boolean){
        this.weakVisionChecked = v;
    };
    public setAdminChecked(v: boolean){
        this.adminChecked = v;
    };
    public setComputerSelfEfficiacyChecked(v: boolean){
        this.computerSelfEfficiacyChecked = v;
    };
    public setLangChecked(v: boolean){
        this.adminChecked = v;
    };
    public getRoleChecked(){
        return this.roleChecked;
    };
    public getWeakVisionChecked(){
        return this.weakVisionChecked;
    };
    public getAdminChecked(){
        return this.adminChecked;
    };
    public getComputerSelfEfficiacyChecked(){
        return this.computerSelfEfficiacyChecked;
    };
    public getLangChecked(){
        return this.adminChecked;
    };

}
