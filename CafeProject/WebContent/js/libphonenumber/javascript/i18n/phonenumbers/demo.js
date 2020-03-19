/**
 * @license
 * Copyright (C) 2010 The Libphonenumber Authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @fileoverview  Phone Number Parser Demo.
 *
 * @author Nikolaos Trogkanis
 */

goog.require('goog.dom');
goog.require('goog.json');
goog.require('goog.proto2.ObjectSerializer');
goog.require('goog.string.StringBuffer');
goog.require('i18n.phonenumbers.AsYouTypeFormatter');
goog.require('i18n.phonenumbers.PhoneNumberFormat');
goog.require('i18n.phonenumbers.PhoneNumberType');
goog.require('i18n.phonenumbers.PhoneNumberUtil');
goog.require('i18n.phonenumbers.PhoneNumberUtil.ValidationResult');
goog.require('i18n.phonenumbers.ShortNumberInfo');


function phoneNumberParser() {
  var $ = goog.dom.getElement;
  var phoneNumber = $('phoneNo').value;
  var regionCode = $('nationNo').value.toUpperCase();

switch(regionCode){
  case  "1":
  var regionCode="US";
  break;
  case "7":
  var regionCode="RU";
  break;
 case "20":
 var regionCode="EG";
 break;
 case "27":
 var regionCode="ZA";
 break;
 case "30":
 var regionCode="GR";
 break;
 case "31":
 var regionCode="NL";
 break;
 case "32":
 var regionCode="BE";
 break;
 case "33":
 var regionCode="FR";
 break;
 case "34":
 var regionCode="ES";
 break;
 case "36":
 var regionCode="HU";
 break;
 case "39":
 var regionCode="IT";
 break;
 case "40":
 var regionCode="RO";
 break;
 case "41":
 var regionCode="CH";
 break;
 case "43":
 var regionCode="AT";
 break;
 case "44":
 var regionCode="GB";
 break;
 case "45":
 var regionCode="DK";
 break;
 case "46":
 var regionCode="SE";
 break;
 case "47":
 var regionCode="NO";
 break;
 case "48":
 var regionCode="PL";
 break;
 case "49":
 var regionCode="DE";
 break;
 case "51":
 var regionCode="PE";
 break;
 case "52":
 var regionCode="MX";
 break;
 case "53":
 var regionCode="CU";
 break;
 case "54":
 var regionCode="AR";
 break;
 case "55":
 var regionCode="BR";
 break;
 case "56":
 var regionCode="CL";
 break;
 case "57":
 var regionCode="CO";
 break;
 case "58":
 var regionCode="VE";
 break;
 case "60":
 var regionCode="MY";
 break;
 case "61":
 var regionCode="AU";
 break;
 case "62":
 var regionCode="ID";
 break;
 case "63":
 var regionCode="PH";
 break;
 case "64":
 var regionCode="NZ";
 break;
 case "65":
 var regionCode="SG";
 break;
 case "66":
 var regionCode="TH";
 break;
 case "81":
 var regionCode="JP";
 break;
 case "82":
 var regionCode="KR";
 break;
 case "84":
 var regionCode="VN";
 break;
 case "86":
 var regionCode="CN";
 break;
 case "90":
 var regionCode="TR";
 break;
 case "91":
 var regionCode="IN";
 break;
 case "92":
 var regionCode="PK";
 break;
 case "93":
 var regionCode="AF";
 break;
 case "94":
 var regionCode="LK";
 break;
 case "95":
 var regionCode="MM";
 break;
 case "98":
 var regionCode="IR";
 break;
case "211":
var regionCode="SS";
break;
case "212":
var regionCode="MA";
break;
case "213":
var regionCode="DZ";
break;
case "216":
var regionCode="TN";
break;
case "218":
var regionCode="LY";
break;
case "220":
var regionCode="GM";
break;
case "221":
var regionCode="SN";
break;
case "222":
var regionCode="MR";
break;
case "223":
var regionCode="ML";
break;
case "224":
var regionCode="GN";
break;
case "225":
var regionCode="CI";
break;
case "226":
var regionCode="BF";
break;
case "227":
var regionCode="NE";
break;
case "228":
var regionCode="TG";
break;
case "229":
var regionCode="BJ";
break;
case "230":
var regionCode="MU";
break;
case "231":
var regionCode="LR";
break;
case "232":
var regionCode="SL";
break;
case "233":
var regionCode="GH";
break;
case "234":
var regionCode="NG";
break;
case "235":
var regionCode="TD";
break;
case "236":
var regionCode="CF";
break;
case "237":
var regionCode="CM";
break;
case "238":
var regionCode="CV";
break;
case "239":
var regionCode="ST";
break;
case "240":
var regionCode="GQ";
break;
case "241":
var regionCode="GA";
break;
case "242":
var regionCode="CG";
break;
case "243":
var regionCode="CD";
break;
case "244":
var regionCode="AO";
break;
case "245":
var regionCode="GW";
break;
case "246":
var regionCode="IO";
break;
case "247":
var regionCode="AC";
break;
case "248":
var regionCode="SC";
break;
case "249":
var regionCode="SD";
break;
case "250":
var regionCode="RW";
break;
case "251":
var regionCode="ET";
break;
case "252":
var regionCode="SO";
break;
case "253":
var regionCode="DJ";
break;
case "254":
var regionCode="KE";
break;
case "255":
var regionCode="TZ";
break;
case "256":
var regionCode="UG";
break;
case "257":
var regionCode="BI";
break;
case "258":
var regionCode="MZ";
break;
case "260":
var regionCode="ZM";
break;
case "261":
var regionCode="MG";
break;
case "262":
var regionCode="RE";
break;
case "263":
var regionCode="ZW";
break;
case "264":
var regionCode="NA";
break;
case "265":
var regionCode="MW";
break;
case "266":
var regionCode="LS";
break;
case "267":
var regionCode="BW";
break;
case "268":
var regionCode="SZ";
break;
case "269":
var regionCode="KM";
break;
case "290":
var regionCode="SH";
break;
case "291":
var regionCode="ER";
break;
case "297":
var regionCode="AW";
break;
case "298":
var regionCode="FO";
break;
case "299":
var regionCode="GL";
break;
case "350":
var regionCode="GI";
break;
case "351":
var regionCode="PT";
break;
case "352":
var regionCode="LU";
break;
case "353":
var regionCode="IE";
break;
case "354":
var regionCode="IS";
break;
case "355":
var regionCode="AL";
break;
case "356":
var regionCode="MT";
break;
case "357":
var regionCode="CY";
break;
case "358":
var regionCode="FI";
break;
case "359":
var regionCode="BG";
break;
case "370":
var regionCode="LT";
break;
case "371":
var regionCode="LV";
break;
case "372":
var regionCode="EE";
break;
case "373":
var regionCode="MD";
break;
case "374":
var regionCode="AM";
break;
case "375":
var regionCode="BY";
break;
case "376":
var regionCode="AD";
break;
case "377":
var regionCode="MC";
break;
case "378":
var regionCode="SM";
break;
case "380":
var regionCode="UA";
break;
case "381":
var regionCode="RS";
break;
case "382":
var regionCode="ME";
break;
case "383":
var regionCode="XK";
break;
case "385":
var regionCode="HR";
break;
case "386":
var regionCode="SI";
break;
case "387":
var regionCode="BA";
break;
case "389":
var regionCode="MK";
break;
case "420":
var regionCode="CZ";
break;
case "421":
var regionCode="SK";
break;
case "423":
var regionCode="LI";
break;
case "500":
var regionCode="FK";
break;
case "501":
var regionCode="BZ";
break;
case "502":
var regionCode="GT";
break;
case "503":
var regionCode="SV";
break;
case "504":
var regionCode="HN";
break;
case "505":
var regionCode="NI";
break;
case "506":
var regionCode="CR";
break;
case "507":
var regionCode="PA";
break;
case "508":
var regionCode="PM";
break;
case "509":
var regionCode="HT";
break;
case "590":
var regionCode="GP";
break;
case "591":
var regionCode="BO";
break;
case "592":
var regionCode="GY";
break;
case "593":
var regionCode="EC";
break;
case "594":
var regionCode="GF";
break;
case "595":
var regionCode="PY";
break;
case "596":
var regionCode="MQ";
break;
case "597":
var regionCode="SR";
break;
case "598":
var regionCode="UY";
break;
case "599":
var regionCode="CW";
break;
case "670":
var regionCode="TL";
break;
case "672":
var regionCode="NF";
break;
case "673":
var regionCode="BN";
break;
case "674":
var regionCode="NR";
break;
case "675":
var regionCode="PG";
break;
case "676":
var regionCode="TO";
break;
case "677":
var regionCode="SB";
break;
case "678":
var regionCode="VU";
break;
case "679":
var regionCode="FJ";
break;
case "680":
var regionCode="PW";
break;
case "681":
var regionCode="WF";
break;
case "682":
var regionCode="CK";
break;
case "683":
var regionCode="NU";
break;
case "685":
var regionCode="WS";
break;
case "686":
var regionCode="KI";
break;
case "687":
var regionCode="NC";
break;
case "688":
var regionCode="TV";
break;
case "689":
var regionCode="PF";
break;
case "690":
var regionCode="TK";
break;
case "691":
var regionCode="FM";
break;
case "692":
var regionCode="MH";
break;
case "800":
var regionCode="001";
break;
case "808":
var regionCode="001";
break;
case "850":
var regionCode="KP";
break;
case "852":
var regionCode="HK";
break;
case "853":
var regionCode="MO";
break;
case "855":
var regionCode="KH";
break;
case "856":
var regionCode="LA";
break;
case "870":
var regionCode="001";
break;
case "878":
var regionCode="001";
break;
case "880":
var regionCode="BD";
break;
case "881":
var regionCode="001";
break;
case "882":
var regionCode="001";
break;
case "883":
var regionCode="001";
break;
case "886":
var regionCode="TW";
break;
case "888":
var regionCode="001";
break;
case "960":
var regionCode="MV";
break;
case "961":
var regionCode="LB";
break;
case "962":
var regionCode="JO";
break;
case "963":
var regionCode="SY";
break;
case "964":
var regionCode="IQ";
break;
case "965":
var regionCode="KW";
break;
case "966":
var regionCode="SA";
break;
case "967":
var regionCode="YE";
break;
case "968":
var regionCode="OM";
break;
case "970":
var regionCode="PS";
break;
case "971":
var regionCode="AE";
break;
case "972":
var regionCode="IL";
break;
case "973":
var regionCode="BH";
break;
case "974":
var regionCode="QA";
break;
case "975":
var regionCode="BT";
break;
case "976":
var regionCode="MN";
break;
case "977":
var regionCode="NP";
break;
case "979":
var regionCode="001";
break;
case "992":
var regionCode="TJ";
break;
case "993":
var regionCode="TM";
break;
case "994":
var regionCode="AZ";
break;
case "995":
var regionCode="GE";
break;
case "996":
var regionCode="KG";
break;
case "998":
var regionCode="UZ";
break;
}

  // var carrierCode = $('carrierCode').value;
  var output = new goog.string.StringBuffer();
  try {
    var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();
    var number = phoneUtil.parseAndKeepRawInput(phoneNumber, regionCode);


    var isPossible = phoneUtil.isPossibleNumber(number);


    if (!isPossible) {

      var PNV = i18n.phonenumbers.PhoneNumberUtil.ValidationResult;


    } else {
      var isNumberValid = phoneUtil.isValidNumber(number);

      var PNT = i18n.phonenumbers.PhoneNumberType;

    }


    var PNF = i18n.phonenumbers.PhoneNumberFormat;

    output.append(isNumberValid ?
                  phoneUtil.format(number, PNF.E164) :
                  'invalid');



  } catch (e) {
    output.append('\n' + e.toString());
  }
  var returnValue=output.toString();
  return returnValue;
}

goog.exportSymbol('phoneNumberParser', phoneNumberParser);
