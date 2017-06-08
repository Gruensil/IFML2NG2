import { Injectable, OnInit } from '@angular/core';

import { LowResImages } from '../data/lowResImages';
import { HighResImages } from '../data/highResImages';
import { lang_EN_US } from '../data/lang_EN_US';
import { lang_DE_DE } from '../data/lang_DE_DE';

import { Image } from '../data/image';
import { LangString } from '../data/string';

@Injectable()
export class ResourceService {
    private images: Image[];
    private langStrings: LangString[];

    constructor(){
        this.setImageFile("low");
        this.setLangFile("enus");
    }

    public setImageFile(key:string){
        if(key === 'low'){
            this.images = LowResImages;
        }else{
            this.images = HighResImages;
        }
    }

    public setLangFile(key:string){
        if(key === "enus"){
            this.langStrings = lang_EN_US;
        }else if(key === "dede"){
            this.langStrings = lang_DE_DE;
        }
    }

    public getImagePath(key:string){
        if(this.images != undefined && this.images.length > 0){
            var image: Image;
            image = this.images.find(
                s => s.key == key
            );
            return image.path;
        }else{
            return undefined;
        }
    }    

    public getLangString(key:string){
        if(this.langStrings != undefined && this.langStrings.length > 0){
            var langString: LangString;
            langString = this.langStrings.find(function(s){
                return s.key == key;
            });
            console.log(key);
			if(langString != undefined){
				return langString.text;
			}
        }
		return key;
    }
}