import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import iziToast, { IziToast } from "izitoast";
@Component({
  selector: 'app-main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.scss']
})
export class MainComponent implements OnInit {

  constructor(private client: HttpClient) { }

  filledCorrect: Boolean = true
  error: String = ""

  ngOnInit(): void {
  }

  onSend(form : any, data : any) {
    if(form.valid) {
      this.filledCorrect = true;
      this.client.post(data["url"], {
        username: data["username"],
        content: data["content"]
      }, {
        headers: new HttpHeaders().set("content-type", "application/json")
      }).subscribe(data => {
        iziToast.success({title: "Erfolg", message: "Dein Webhook wurde erfolgreich gesendet", timeout: 3000, position: "bottomCenter"})
        this.error = ""
      }, err => {
        this.error = `${err["status"]} ${err["statusText"]}`
      })
    } else {
      this.filledCorrect = false
    }
  }

}
