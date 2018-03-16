import os
from HTMLParser import HTMLParser


class MyHTMLParser(HTMLParser):
    capturing = False
    line = ""

    def handle_starttag(self, tag, attrs):
        if tag == "tr":
            for name, value in attrs:
                if name == "class" and value == "summaryRow noDetails":
                    self.capturing = True
                    self.line = ""
                if name == "class" and value == "row-summary no-details":
                    self.capturing = True
                    self.line = ""

    def handle_endtag(self, tag):
        if tag == "tr":
            self.capturing = False
            if self.line != "":
                self.line = self.line.replace(",,", ",")
                # print self.line
                self.process_text(self.line)
            self.line = ""

    def handle_data(self, data):
        if self.capturing == True:
            data = data.replace(',', '')
            data = data.strip()
            data = data.rstrip()
            if self.line != "":
                self.line = self.line + ","
            self.line = self.line + data

    def process_text(self, text):
        arry = text.strip().split(",")
        if "%" in arry[2]:
            # print "BOND,",text
            self.process_bond(text)
        elif arry[1].endswith(" P") or arry[1].endswith(" C"):
            # print "OPT,",text
            self.process_opt(text)
        else:
            # print "STK,",text
            self.process_stk(text)

    def process_opt(self, text):
        arry = text.strip().split(",")
        account = arry[0].strip().rstrip()
        contract = arry[1].strip().rstrip()
        tradeTime = arry[2].strip().rstrip()
        settleDate = arry[3].strip().rstrip()
        dash = arry[4].strip().rstrip()
        side = arry[5].strip().rstrip()
        quantity = arry[6].strip().rstrip()
        price = arry[7].strip().rstrip()
        proceeds = arry[8].strip().rstrip()
        comish = arry[9].strip().rstrip()
        tax = arry[10].strip().rstrip()
        codes = arry[11].strip().rstrip()
        yld = "0.00%"
        accruedInterest = "0.00"
        print "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s" % (tradeTime, settleDate, account, "OPT", contract, side, quantity, price, proceeds, comish, tax, yld, accruedInterest, codes)

    def process_stk(self, text):
        arry = text.strip().split(",")
        account = arry[0].strip().rstrip()
        contract = arry[1].strip().rstrip()
        tradeTime = arry[2].strip().rstrip()
        settleDate = arry[3].strip().rstrip()
        dash = arry[4].strip().rstrip()
        side = arry[5].strip().rstrip()
        quantity = arry[6].strip().rstrip()
        price = arry[7].strip().rstrip()
        proceeds = arry[8].strip().rstrip()
        comish = arry[9].strip().rstrip()
        tax = arry[10].strip().rstrip()
        codes = arry[11].strip().rstrip()
        yld = "0.00%"
        accruedInterest = "0.00"
        print "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s" % (tradeTime, settleDate, account, "STK", contract, side, quantity, price, proceeds, comish, tax, yld, accruedInterest, codes)

    def process_bond(self, text):
        arry = text.strip().split(",")
        account = arry[0].strip().rstrip()
        contract = arry[1].strip().rstrip()
        tradeTime = arry[3].strip().rstrip()
        settleDate = arry[4].strip().rstrip()
        dash = arry[5].strip().rstrip()
        side = arry[6].strip().rstrip()
        quantity = arry[7].strip().rstrip()
        price = arry[8].strip().rstrip()
        proceeds = arry[9].strip().rstrip()
        comish = arry[10].strip().rstrip()
        tax = "0.00"
        codes = arry[12].strip().rstrip()
        yld = arry[2].strip().rstrip()
        accruedInterest = arry[11].strip().rstrip()
        print "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s" % (tradeTime, settleDate, account, "BOND", contract, side, quantity, price, proceeds, comish, tax, yld, accruedInterest, codes)


for htmlfile in sorted(os.listdir("data")) :
    if htmlfile.startswith("DailyTradeReport.") and htmlfile.endswith(".html"):
        with open(os.path.join("data", htmlfile), "r") as htmlfile:
            data = htmlfile.read()
            parser = MyHTMLParser()
            parser.feed(data)
