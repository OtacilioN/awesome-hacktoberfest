from PyQt5 import QtCore, QtGui, QtWidgets
import requests
import bs4
import notifiers
import time
import datetime



# print("\n")
# formatted_output_data_wordwide()

class Ui_Covid19_Tracker(object):
    def setupUi(self, Covid19_Tracker):
        Covid19_Tracker.setObjectName("Covid19_Tracker")
        Covid19_Tracker.resize(482, 576)
        self.Title = QtWidgets.QLabel(Covid19_Tracker)
        self.Title.setGeometry(QtCore.QRect(80, 0, 321, 31))
        font = QtGui.QFont()
        font.setFamily("Times New Roman")
        font.setPointSize(18)
        font.setBold(True)
        font.setWeight(75)
        self.Title.setFont(font)
        self.Title.setObjectName("Title")
        self.Search_label = QtWidgets.QLabel(Covid19_Tracker)
        self.Search_label.setGeometry(QtCore.QRect(10, 70, 151, 16))
        font = QtGui.QFont()
        font.setFamily("Times New Roman")
        font.setPointSize(14)
        self.Search_label.setFont(font)
        self.Search_label.setObjectName("Search_label")
        self.search_Text = QtWidgets.QLineEdit(Covid19_Tracker)
        self.search_Text.setGeometry(QtCore.QRect(170, 70, 171, 20))
        self.search_Text.setText("Enter country name here")
        self.search_Text.setObjectName("search_Text")
        self.search_Button = QtWidgets.QPushButton(Covid19_Tracker)
        self.search_Button.setGeometry(QtCore.QRect(370, 70, 75, 23))
        self.search_Button.setObjectName("search_Button")
        self.search_Button.clicked.connect(self.formatted_output_data_country) 
        self.search_Button.clicked.connect(self.formatted_output_data_wordwide)  
        self.Details_Textbox = QtWidgets.QTextBrowser(Covid19_Tracker)
        self.Details_Textbox.setGeometry(QtCore.QRect(160, 110, 256, 192))
        self.Details_Textbox.setObjectName("Details_Textbox")
        f = self.Details_Textbox.font()
        f.setPointSize(25) # sets the size to 27
        f.setFamily("Times New Roman")
        self.Details_Textbox.setFont(f)
        self.Details_label = QtWidgets.QLabel(Covid19_Tracker)
        self.Details_label.setGeometry(QtCore.QRect(90, 110, 61, 20))
        font = QtGui.QFont()
        font.setFamily("Times New Roman")
        font.setPointSize(14)
        self.Details_label.setFont(font)
        self.Details_label.setObjectName("Details_label")
        self.Worldwide_label = QtWidgets.QLabel(Covid19_Tracker)
        self.Worldwide_label.setGeometry(QtCore.QRect(20, 330, 141, 21))
        font = QtGui.QFont()
        font.setFamily("Times New Roman")
        font.setPointSize(14)
        self.Worldwide_label.setFont(font)
        self.Worldwide_label.setObjectName("Worldwide_label")
        self.Worldwide_text = QtWidgets.QTextBrowser(Covid19_Tracker)
        self.Worldwide_text.setGeometry(QtCore.QRect(160, 330, 261, 201))
        self.Worldwide_text.setObjectName("Worldwide_text")
        f = self.Worldwide_text.font()
        f.setPointSize(25) # sets the size to 27
        f.setFamily("Times New Roman")
        self.Worldwide_text.setFont(f)
        self.Refresh_Button = QtWidgets.QPushButton(Covid19_Tracker)
        self.Refresh_Button.setGeometry(QtCore.QRect(304, 540, 81, 23))
        self.Refresh_Button.setObjectName("Refresh_Button")
        self.Refresh_Button.clicked.connect(self.formatted_output_data_wordwide)
        self.Exit_button = QtWidgets.QPushButton(Covid19_Tracker)
        self.Exit_button.setGeometry(QtCore.QRect(400, 540, 75, 23))
        self.Exit_button.setObjectName("Exit_button")
        self.Exit_button.clicked.connect(exit)

        self.retranslateUi(Covid19_Tracker)
        QtCore.QMetaObject.connectSlotsByName(Covid19_Tracker)
    def exit(self):
        sys.exit(app.exec_())
    # def showdata(self):
    #     self.Details_Textbox.setText(self.formatted_output_data_country)
    # #Web scraping function 
    # # Worldwide

    def formatted_output_data_wordwide(self):
        wb_site='https://www.worldometers.info/coronavirus/?utm_campaign=homeAdvegas1'
        data=self.get_covid_details(wb_site)
        formatted = bs4.BeautifulSoup(data.text, 'html.parser')
        info=formatted.find_all(id="maincounter-wrap")
        formdat=""
        for id in info:
            all_text=id.find("h1").get_text()
            all_data=id.find("span").get_text()
            data=all_text+" "+all_data+"\n"
            formdat=formdat+data
        self.Worldwide_text.setText(formdat)

    def formatted_output_data_country(self):
        search=self.search_Text.text()
        search.lower()
        if (search=='usa' or search=='america' or search=='united states'):
            search='us'
        wb_site_country="https://www.worldometers.info/coronavirus/country/"+search
        data_country=self.get_covid_details(wb_site_country)
        formatted_country = bs4.BeautifulSoup(data_country.text, 'html.parser')
        info=formatted_country.find_all(id="maincounter-wrap")
        formdat=""
        for id in info:
            all_text=id.find("h1").get_text()
            all_data=id.find("span").get_text()
            data=all_text+" "+all_data+"\n"
            formdat=formdat+data
        self.Details_Textbox.setText(formdat)
            
    #url passing function
    def get_covid_details(self, url):
        value = requests.get(url)
        return value

    def retranslateUi(self, Covid19_Tracker):
        _translate = QtCore.QCoreApplication.translate
        Covid19_Tracker.setWindowTitle(_translate("Covid19_Tracker", "COVID19 TRACKER"))
        self.Title.setText(_translate("Covid19_Tracker", "COVID-19 DATA TRACKER"))
        self.Search_label.setText(_translate("Covid19_Tracker", "Search By Country:"))
        self.search_Button.setText(_translate("Covid19_Tracker", "Grab Details"))
        self.Details_label.setText(_translate("Covid19_Tracker", "Details:"))
        self.Worldwide_label.setText(_translate("Covid19_Tracker", "Worldwide Data:"))
        self.Refresh_Button.setText(_translate("Covid19_Tracker", "Refresh Data"))
        self.Exit_button.setText(_translate("Covid19_Tracker", "Exit"))


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Covid19_Tracker = QtWidgets.QDialog()
    ui = Ui_Covid19_Tracker()
    ui.setupUi(Covid19_Tracker)
    Covid19_Tracker.show()
    sys.exit(app.exec_())
