import { Injectable } from '@angular/core';
import { menu } from '../../environments/config/application';

@Injectable({
  providedIn: 'root'
})
export class ConfigService {

  constructor() { }

  public getMenu(){
    return menu;
  }
}
