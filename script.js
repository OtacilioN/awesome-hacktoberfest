var deg =6;
const hr =document.querySelector('.hour_hand');
const mn = document.querySelector('.min_hand');
const sc =document.querySelector('.sec_hand');

setInterval(() => {
    let day =new Date ()
    let hh =day.getHours()*30;
    let mm =day.getMinutes()*deg;
    let ss=day.getSeconds()*deg;
    hr.style.transform =`rotateZ(${hh+(mm/12)}deg)`;
    mn.style.transform =`rotateZ(${mm}deg)`;
    sc.style.transform =`rotateZ(${ss}deg)`;
});


//code for digital clock
setInterval(() => {
   let time = document.querySelector('#time') ;
   let date = new Date();
   let hours =date.getHours();
   let minutes = date.getMinutes();
   let seconds = date.getSeconds();
   let day_night ='PM';

   if(hours>12){
       day_night='PM';
       hours = hours-12;
   }

   if(hours<10){
       hours ="0" + hours;
   }
   if(minutes<10){
       minutes="0"+minutes;
   }
   if(seconds<10){
       seconds="0"+seconds;
   }

   time.textContent = hours + ":"+ minutes+":"+seconds+":"+""+day_night;

});

let hours = 1;
if(hours>12){
    day_night='PM';
    hours = hours-12;
}
console.log(hours);