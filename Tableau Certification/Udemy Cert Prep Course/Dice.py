# -*- coding: utf-8 -*-
"""
Created on Thu Dec 24 11:38:31 2015

@author: LukasHalim
"""

from bs4 import BeautifulSoup
from urllib2 import urlopen
import csv
jobdesc = ""
post = dict()
import requests
import string
    

with open('DiceJobs.csv', 'w') as csvfile:
    fieldnames = ['Title','Location','Company','Salary','SearchURL','URL','SQL','Hadoop','Oracle','Excel','Teradata','DB2','Qlik','SAS','Agile','Scrum','Statistics','PowerPoint','Python','Matlab','SQL Server','SSRS','ETL']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames,dialect="excel",lineterminator='\n')
    writer.writeheader()    
    for i in range(1,30):        
        SearchURL = 'https://www.dice.com/jobs/q-tableau-limit-30-startPage-' + str(i) + '-limit-30-jobs?searchid=9787308578379'
        print "search url ", SearchURL
        response=urlopen(SearchURL)    
        soup=BeautifulSoup(response.read().decode('utf-8', 'ignore'))    
        for a in soup.find_all('a', {"class": "dice-btn-link"}, href=True):
            url = a['href']
            if  url.find('jobs/detail') > 0:
                #print "opening url ", url
                response=requests.get(url)            
                soup=BeautifulSoup(response.text)    
                if not soup.find("h1", { "class" : "jobTitle" }) is None and not soup.find("div", { "class" : "job-info" }) is None and not soup.find("div", { "id" : "jobdescSec" }) is None:
                    jobDesc = soup.find("div", { "id" : "jobdescSec" }).get_text().encode('ascii','ignore').upper()                    
                    post['Title'] = soup.find("h1", { "class" : "jobTitle" }).get_text().encode('ascii','ignore').strip()
                    post['Location'] = soup.find("li", { "class" : "location" }).get_text().encode('ascii','ignore').strip()
                    post['Company'] = soup.find("title").get_text().encode('ascii','ignore').split("-")[1].strip()
                    if string.find(response.text,"No Salary Listed") == -1:
                        post['Salary'] = soup.find("span", {"class" : "mL20"}).get_text().encode('ascii','ignore')
                    post['SearchURL'] = SearchURL
                    post['URL'] = url                    
                    post['SQL'] = string.find(jobDesc,"SQL") > -1
                    post['Hadoop'] = string.find(jobDesc,"HADOOP") > -1
                    post['Oracle'] = string.find(jobDesc,"ORACLE") > -1
                    post['Excel'] = string.find(jobDesc,"EXCEL") > -1
                    post['Teradata'] = string.find(jobDesc,"TERADATA") > -1
                    post['DB2'] = string.find(jobDesc,"DB2") > -1
                    post['Qlik'] = string.find(jobDesc,"QLIK") > -1
                    post['SAS'] = string.find(jobDesc,"SAS") > -1
                    post['Agile'] = string.find(jobDesc,"AGILE") > -1
                    post['Scrum'] = string.find(jobDesc,"SCRUM") > -1
                    post['Statistics'] = string.find(jobDesc,"STATISTICS") > -1                    
                    post['PowerPoint'] = string.find(jobDesc,"POWERPOINT") > -1                    
                    post['Python'] = string.find(jobDesc,"PYTHON") > -1                    
                    post['Matlab'] = string.find(jobDesc,"MATLAB") > -1                    
                    post['SQL Server'] = string.find(jobDesc,"SQL Server") > -1                    
                    post['SSRS'] = string.find(jobDesc,"SSRS") > -1           
                    post['ETL'] = string.find(jobDesc,"ETL") > -1                               
                    writer.writerow(post)
                    post.clear