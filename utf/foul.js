/*
Foul - Form Validation Language Version 1.7.1
Copyright (C) 2005  Bryan English

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

*/

function Foul(){

   //----------------------------------------------------------------------------//	
   // Properties

   this.version = '1.7.2';
   this.form = null;                //shortcut to form in question//
   this.breakpoints = false;        //auto checks on blur//
   this.interactive = false;        //auto formats on blur//
   this.tests = new Array();        //array of test strings//
   this.tests_index = new Array();  //easy lookup for field tests : tests_index['field'][n] = tests index//
	this.formats = new Array();      //array of format strings//
   this.formats_index = new Array();//easy lookup for field formats//
	this.local = new Array();        //used as a alternative to a form field for add'l tests//
	this.defmsg = {                  //used to automatically add error messages//
		"^\~([^~]+)\~$": "[[field]] is a required field.",
		" is (null|empty|blank)": "[[field]] is a required field.",
		" not email": "Please enter a valid email address.",
		" not (date\-us|date\-us\-y2k)": "Please enter a valid date in the form of mm/dd/yyyy.",
      " not zip-state-match(\-us)?": "Please verify the zip code you entered is correct for the state.",
		" not (zip(\-us)?|zipcode(\-us)?)": "Please enter a valid ZIP.",
		" not (state(\-us)?|postalcode(\-us)?)": "Please enter a valid state.",
		" not url\-http": "Please enter a valid url in the form of http://domain/path/file",
		" not url\-ftp": "Please enter a valid ftp url in the form of ftp://[user:pass@]domain/path/file",
		" not url\-news": "Please enter a valid news url in the form of news://domain/path/file",
		" not url": "Please enter a valid url in the form of protocol://[user:pass@]domain/path/file",
      " not (ssn|social\-security\-number)": "Please specify a valid social security number.",
		"numeric": " is a number."
		};	

   // Constants//
   this.STATES = new Array('AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AA','AE','AE','AE','AP');
   this.STATE_ZIP_LOOKUP = {'FM':'969','AS':'96799','GU':'969','AL':'35-36','AK':'995-999','AZ':'85-86','AR':'716-729','CA':'900-961','CO':'80-81','CT':'06','DE':'197-199','DC':'200-205','FL':'32-34','GA':'30-31','HI':'967-968','ID':'832-839','IL':'60-62','IN':'46-47','IA':'50-52','KS':'66-67','KY':'40-42','LA':'700-715','ME':'039-049','MH':'969','MD':'206-219','MA':'010-027','MI':'48-49','MN':'55-56','MS':'386-399','MO':'63-65','MT':'59','NE':'68-69','NV':'89','NH':'030-038','NJ':'07-08','NM':'87-88','NY':'10-14','NC':'27-28','ND':'58','MP':'969','OH':'43-45','OK':'73-73','OR':'97','PW':'969','PA':'150-196','PR':'006-009','RI':'028-029','SC':'29','SD':'57','TN':'370-385','TX':'75-79','UT':'84','VT':'05','VI':'006-009','VA':'220-246','WA':'980-994','WV':'247-269','WI':'53-54','WY':'820-831','AE':'09','AA':'340','AP':'962-966'};

	//----------------------------------------------------------------------------//	
   // Methods

	//--------------------------------------------//
	// ADD adds a test
	//--------------------------------------------//
	this.add = function(v,m,i){
      var checksum = v.split("~"); //check for typos//
      if ((checksum.length+1) % 2 == 1){this.error("Syntax error in " + v);}
		if (!m){
			for (var reg in this.defmsg){
				if(v.search(new RegExp(reg)) != -1){
               var field = v.match(/\~([^~]+)\~/)[1];
					m = this.defmsg[reg].replace(/\[\[field\]\]/g,field);
					break;
				}
         }
      }

      if (!m){
         this.error('['+ v +'] Test missing error message.');
      }

      //add fields to index array//
      var matches,re = new RegExp('\~([^~]+)\~','g');
      while(matches = re.exec(v)){
         if (!this.tests_index[RegExp.$1]){
            this.tests_index[RegExp.$1] = new Array();
         }

         this.tests_index[RegExp.$1][this.tests_index[RegExp.$1].length] = this.tests.length;         
      }

      //add to test array//
		this.tests[this.tests.length] = new Array(v,m,i);

   };

	this.when = this.add;

	//--------------------------------------------//
	// FORMAT assigns formatting to a field
	//--------------------------------------------//

   this.format = function(v){
      var checksum = v.split("~"); //check for typos//
      if((checksum.length+1) % 2 == 1){
         this.error("Syntax error in " + v);
      }

      //add fields to index array//
      var matches,re = new RegExp('\~([^~]+)\~','g');
      while(matches = re.exec(v)){
         if (!this.formats_index[RegExp.$1]){
            this.formats_index[RegExp.$1] = new Array();
         }

         this.formats_index[RegExp.$1][this.formats_index[RegExp.$1].length] = this.formats.length;         
      }

      //add to formats array//
      var n = v.match(/\~([^~]+)\~/)[1];
		this.formats[this.formats.length] = new Array(v,n);
   };


      
   //--------------------------------------------//
	// ERROR reports a script error
	//--------------------------------------------//
	this.error = function(e){
      var buffer = 'Foul ' + this.version + ' Error!';
      buffer += '\n_______________________________________\n';
      buffer += e + '\n\n';
      alert(buffer);
   }
   
   //--------------------------------------------//
	// GET VALUE get a value from any form control
	//--------------------------------------------//
	this.get_value = function(e){
		if(e.type!=null)
			switch(e.type){
				case "text": case "hidden": case "password": case "textarea": case "file":return(e.value);break;
				case "checkbox":return(((e.checked)?e.value:''));break;
				case "select-one":var o = e.options[e.selectedIndex];
					return(((o.value==null)?o.text:o.value));break;
				}
		else //pesky radio button//
			for(var cnt=0;cnt<e.length;cnt++)
				if(e[cnt].checked)return(e[cnt].value);

		return(false);
		};


	//--------------------------------------------//
	// STRING MERGE - merges template with data
	//--------------------------------------------//

   this.string_merge = function(template,data,reverse){
      var dindex = (reverse)?data.length-1:0;
      var dend = (reverse)?-1:data.length;
      var cnt = (reverse)?template.length-1:0;
      var end = (reverse)?-1:template.length;
      var inc = (reverse)?-1:1;
      var value = newdata = '';
   
      while (cnt != end && dindex != dend){

         switch (template.charAt(cnt)){

            case 'x': //replace with next data char
               value = data.charAt(dindex);
               dindex+=inc;
            break;

            case 'X': //replace with next data char and add next template char
               cnt+=inc;

               if(reverse){
                  value = template.charAt(cnt) + data.charAt(dindex);
               } else {
                  value = data.charAt(dindex) + template.charAt(cnt);
               }

               dindex+=inc;
            break;

            default: //add template char
               value = template.charAt(cnt); 
            break;
         }

         newdata = ((reverse==null)?newdata:'') + value + ((reverse)?newdata:''); 
         cnt+=inc;
      }

		return(newdata);
	};


	//--------------------------------------------//
	// VALIDATE optional function to do the dirty work
	//--------------------------------------------//
	this.validate = function(form){
		var errors = '';
		this.formatter(form);
		errors = this.test(form);		 
		if(errors!=''){
			alert("There is a problem with your submission:\n"+errors);
			return false;
			}
		return true;
		}	

	//--------------------------------------------//
	// INSPECT - used to auto-format/check on blur
	//--------------------------------------------//
	this.inspect = function(field){

      //attach form to foul object//
      this.form = field.form;

      //format field//
      if (this.interactive && this.formats_index[field.name]){
         for(var cnt=0;cnt<this.formats_index[field.name].length;cnt++){
      		this.tokenize(this.formats[this.formats_index[field.name][cnt]][0]);
         }
      }

      if (this.breakpoints && this.tests_index[field.name]){
         var errors = '';
         //run validation on this field//
         for(var cnt=0;cnt<this.tests_index[field.name].length;cnt++){
            if(this.tokenize(this.tests[this.tests_index[field.name][cnt]][0])){
	   		   alert(this.tests[this.tests_index[field.name][cnt]][1]);
               return;
            }            
         }
      }
	}	

   
   //--------------------------------------------//
	// CHOMP perl ripoff
	//--------------------------------------------//
   this.chomp = function(str){
   	  if(!str)return '';
      str = str.match(/\s*(.*\S)\s*/);
      return str[1];
      }

	//--------------------------------------------//
	// ONION peel layers strings via paranthesis
	//--------------------------------------------//
   this.onion = function(str,start,end){
      
      var cnt,tally = 1;

      for(cnt=1;cnt<str.length && tally!=0;cnt++){
         if(str.charAt(cnt) == start)tally++;
         if(str.charAt(cnt) == end)tally--;
         }
      return(str.substring(1,cnt-1));
      }

	//--------------------------------------------//
	// PARSE foul parser 
	//--------------------------------------------//
   this.tokenize = function(str){

      var left,right,bool = null;
      var result = false;
      str = this.chomp(str);
	  
      //check for paranthesis//
      if(str.charAt(0) == '('){
         left = this.onion(str,"(",")");
         right = str.substring(str.indexOf(left)+left.length,str.length);
         left = str.substring(1,str.length-1);
         result = this.tokenize(left);
         }
      //else just split and eval the left part//
      else{         
         left = str.match(/\~[^\~]+\~.*?(?= and | or |$)/)[0];
         right = str.substring(str.indexOf(left)+left.length,str.length);
         result = this.evaluate(left);
         //-1 result means test was canceled//
			result = (result==-1?false:result)
         }

      bool = right.match(/ or | and |\s*$/)[0];
      right = right.substring(right.indexOf(bool)+bool.length,right.length);

      //get recursive!//
      switch(this.chomp(bool)){
         case "":
            return result;
         case "and":
            return(result && this.tokenize(right));
         case "or":
            return(result || this.tokenize(right));
         }
      }

	//--------------------------------------------//
	// FORMATTER formats the form data            //
	//--------------------------------------------//
   this.formatter = function(form){
      this.form = form;

      for(var cnt=0;cnt<this.formats.length;cnt++)
         this.tokenize(this.formats[cnt][0]);			

      };	
		
	//--------------------------------------------//
	// TEST parseing the tests and create error  //
	//--------------------------------------------//
   this.test = function(form){
		var errors = '';
      this.form = form;

      for(var cnt=0;cnt<this.tests.length;cnt++)
         if(this.tokenize(this.tests[cnt][0]))
			   errors += '\n- ' + this.tests[cnt][1];

		return errors;
      };		 

   //--------------------------------------------//
	// EVALUATE where the field testing is done
	//--------------------------------------------//
   this.evaluate = function(str){
      var list = str.match(/\~([^~]+)\~(?:\s(\S+)(?:\s(.*))?)?/);
      var field = list[1];		
      var value = (this.form[field])?this.get_value(this.form[field]):this.local[field];
      var test = (list[2]==null||list[2]=="")?"null":list[2];
      var param = list[3];      
	  
      switch(test){

			//FORMATTER//         
         case 'as': 
            if(value == null || value == '')return(true);				
				param = param.split(' ');
				switch(param[0]){
					case 'number':
					case 'integer': // remove all non-number chars//
						this.form[field].value = (isNaN(parseInt(value.replace(/[^0-9\.]/g,''))))?'':parseInt(value.replace(/[^0-9\.]/g,''));
						break;
						
					case 'float':
					case 'decimal': // remove all non-number chars//
						this.form[field].value = (isNaN(parseFloat(value.replace(/[^0-9\.]/g,''))))?'':parseFloat(value.replace(/[^0-9\.]/g,''));
						break;

					case 'pad':
					case 'padded':
						var s = new String(value);
						while(s.length < param[1])
							s = param[2] + s;
						this.form[field].value = s;
						break;

               case 'phone-us':
                  var s = value.replace(/\D/g,'');
                  this.form[field].value = this.string_merge('x (Xxx) xxx-xxxx',s,true);
                  break;

               case 'credit-card':
                  var s = value.replace(/\D/g,'');
                  this.form[field].value = this.string_merge('xxxx xxxx xxxx xxxx',s);
                  break;

               case 'ssn':
               case 'social-security-number':
                  var s = value.replace(/\D/g,'');
                  this.form[field].value = this.string_merge('xxx-xx-xxxx',s);
                  break;

               case 'date-us':
                  var s = value.replace(/\s/g,'');
                  var matches = s.match(/(\d\d?)\D(\d\d?)\D(\d\d(?:\d\d)?)/);
                  if (matches){
                     this.form[field].value = matches[1] + '/' + matches[2] + '/' + matches[3];
                  }
                  break;

               case 'date-us-y2k':
                  var s =   value.replace(/\s/g,'');
                  var matches = s.match(/(\d\d?)\D(\d\d?)\D(\d\d(?:\d\d)?)/);
                  if (matches){
                     if (matches[3].length == 2){
                        //hack 2 digit years//
                        d = new Date();
                        max = d.getFullYear() - 2000 + 20;
                        matches[3] = (parseInt(matches[3])>max?'19':'20') + matches[3];
                     }
                     this.form[field].value = matches[1] + '/' + matches[2] + '/' + matches[3];
                  }
                  break;

               case 'url':
               case 'url-http':
                  var matches = value.match(/([a-zA-Z0-9\.\-]+(\/[\S]*)?)\s*$/);
                  this.form[field].value = 'http://' + matches[1];
                  break;

               case 'url-ftp':
                  var matches = value.match(/(([\S]+\:[\S]+\@)?[a-zA-Z0-9\.\-]+(\/[\S]*)?)\s*$/);
                  this.form[field].value = 'ftp://' + matches[1];
                  break;

               case 'url-news':
                  var matches = value.match(/([a-zA-Z0-9\.\-]+(\/[\S]*)?)\s*$/);
                  this.form[field].value = 'news://' + matches[1];
                  break;

               case 'uppercase':
                  this.form[field].value = value.toUpperCase();
                  break;

               default:
                  this.error('"' + test + "\" test doesn't exist.");
                  break;
               }

				return(true);
				break;
			//END FORMATTER//         

			case 'is':
			case 'has':
			case 'does':
         case '=':
            return(this.evaluate('~'+field+'~ '+ param));
            break;

         case '!':
         case 'not':
				var result = this.evaluate('~'+field+'~ '+ param);
				if(result!=-1)
	               return(!this.evaluate('~'+field+'~ '+ param));
				else
				   return(-1);
            break;

         case 'empty':
         case 'blank':
         case 'null':
            if(value == null || value == '')return(true);
            break;

         case 'range':
         case 'between':
            if(value == null || value == '')return(-1);
            param = param.split(/\s/);
				if(value > parseFloat(param[0]) && value < parseFloat(param[1]))return(true);
            break;

         case 'greater-than':
         case '>':
            if(value == null || value == '' || isNaN(value))return(-1);
            value = parseFloat(value);
            param = parseFloat(param);
				if(value > param)return(true);
            break;

         case 'less-than':
         case '<':
            if(value == null || value == '' || isNaN(value))return(-1);
            value = parseFloat(value);
            param = parseFloat(param);
				if(value < param)return(true);
            break;

         case 'email':
            if(value == null || value == '')return(-1);
            if(/^.+\@..+\..+/.test(value))return(true);
            break;

         case 'length':
            if(value == null || value == '')return(-1);
            param = param.split(/\s/);
				if(param.length > 1){
					this.local["_LOCAL_" + field] = parseInt(value.length);
					return(this.evaluate('~_LOCAL_'+field+'~ '+ param.join(' ')));
					}
				else{
					return(value.length == parseInt(param[0]));
					}
            break;

         case 'number':
         case 'float':
         case 'decimal':
         case 'numeric':
            if(value == null || value == '')return(-1);
            if(!isNaN(value))return(true);
            break;

			case 'valid_credit_card':
			case 'valid_cc':
			case 'vcc':
				if(value == null || value == '')return(false);
            value = value.replace(/\D/g,'');
				if (value.length > 19)
					return (false);

				var sum = 0; mul = 1; l = value.length;
				for (i = 0; i < l; i++) {
					var digit = value.substring(l-i-1,l-i);
					var tproduct = parseInt(digit ,10)*mul;
					if (tproduct >= 10)
						sum += (tproduct % 10) + 1;
					else
						sum += tproduct;
					if (mul == 1)
						mul++;
					else
						mul--;
					}
				if ((sum % 10) == 0)return (true);
				break;

         case 'date-us':
            if(value == null || value == '')return(-1);
            if (/\d\d?\/\d\d?\/\d{2,4}/.test(value)){
               //logic validation//
               var pcs = value.match(/(\d\d?)\/(\d\d?)\/(\d{2,4})/);
               var d = new Date(pcs[3],pcs[1]-1,pcs[2]);
               var y = ((pcs[3].length == 2)?d.getYear():d.getFullYear());
               if (y == pcs[3] && d.getMonth()+1 == pcs[1] && d.getDate() == pcs[2])
                  return(true);
            }
            break;

         case 'date-us-y2k':
            if(value == null || value == '')return(-1);
            //wellformed validation//
            if (/\d\d?\/\d\d?\/\d{4}/.test(value)){
               //logic validation//
               var pcs = value.match(/(\d\d?)\/(\d\d?)\/(\d{4})/);
               var d = new Date(pcs[3],pcs[1]-1,pcs[2]);
               if (d.getFullYear() == pcs[3] && d.getMonth()+1 == pcs[1] && d.getDate() == pcs[2])
                  return(true);
               }
            break;

         case 'password':
            if(value == null || value == '')return(-1);         
            if((!/\s|\t|\n|\r/.test(value)) && this.evaluate('~'+ field +'~ length > 8'))return(true);
            break;

         case '==':
         case 'same-as':
         case 'equal-to':
            if(value == null || value == '')return(-1);
            if(value == this.get_value(this.form[this.chomp(param)]))return(true);
            break;

         case 'password-verified':
         case 'password-confirmed':
            if(value == null || value == '')return(-1);
            if(value == this.get_value(this.form['confirm_' + field]))return(true);
            break;

         case 'blanks':
         case 'spaces':
            if(value == null || value == '')return(-1);                   
            if(/\s/.test(value))return(true);
            break;

         case 'url':
            if(value == null || value == '')return(-1);                   
            if(/^(https?|ftp|news)\:\/\/([\S]+\:[\S]+\@)?[a-zA-Z0-9\.\-]+(\/[\S]*)?$/.test(value))return(true);
            break;

         case 'url-http':
            if(value == null || value == '')return(-1);                   
            if(/^https?\:\/\/[a-zA-Z0-9\.\-]+(\/[\S]*)?$/.test(value))return(true);
            break;

         case 'url-ftp':
            if(value == null || value == '')return(-1);                   
            if(/^ftp\:\/\/([\S]+\:[\S]+\@)?[a-zA-Z0-9\.\-]+(\/[\S]*)?$/.test(value))return(true);
            break;

         case 'url-news':
            if(value == null || value == '')return(-1);                   
            if(/^news\:\/\/[a-zA-Z0-9\.\-]+(\/[\S]*)?$/.test(value))return(true);
            break;

         case 'zip':
         case 'zipcode':
         case 'zipcode-us':
         case 'zip-us':
            if (value == null || value == '')return(-1);
            if (/^\d{5}(\-\d{4})?$/.test(value))return true;
            break;

         case 'state':
         case 'state-us':
         case 'postalcode':
         case 'postalcode-us':
            if (value == null || value == '')return(-1);
            var re = new RegExp('^(' + this.STATES.join('|') + ')$','i');
            if (re.test(value))return true;
            break;

         case 'zip-state-match':
         case 'zip-state-match-us':
            if (value == null || value == '')return(-1);
   			var result = this.evaluate('~'+ param +'~ state');
            if (result && this.form[param]){
               var state = this.get_value(this.form[param]).toUpperCase();
               var range = this.STATE_ZIP_LOOKUP[state].split('-');
               var digits = range[0].length;
               var zip = parseInt(value.substring(0,digits));
               if (range.length > 1){
                  if (zip >= parseInt(range[0]) && zip <= parseInt(range[1])) return true;
               } else {
                  if (zip == parseInt(range[0])) return true
               }
            } else {
               return(-1);
            }

            break;

         case 'ssn':
         case 'social-security-number':
            if (value == null || value == '')return(-1);
            if (/^\d\d\d\-\d\d\-\d\d\d\d$/.test(value) &&
               !/(^000)|(\-00\-)|(0000$)/.test(value) &&
               !/987\-65\-432[0-9]/.test(value)) return true;
            break;

         case 'file-type':
            if (value == null || value == '')return(-1);
            var params = param.split(/[\s,]/g);
            for (cnt=0;cnt<params.length;cnt++){
               var re = new RegExp('\.'+ params[cnt] +'$','ig');
               if (re.test(value)) return true;
            }
            break;

         case 'file-type-image':
            if (value == null || value == '')return(-1);
            if (this.evaluate('~' + field + '~ file-type ani b3d bmp dib cam clp crw cr2 cur dcm acr ima dcx dds djvu iw44 ecw emf eps fpx fsh g3 gif icl ico ics ids iff lbm img jp2 jpc j2k jpf jpg jpeg jpe jpm kdc ldf lwf mng jng nlm nol ngg gsm pbm pcd pcx pgm png ppm psd psp ras sun raw rle sff sfw sgi rgb sid swf tga tif tiff wbmp wmf xbm xpm')) return true;
            break;
         

         case 'file-type-executable':
            if (value == null || value == '')return(-1);
            if (this.evaluate('~' + field + '~ file-type ade adp bas chm cmd cpl crt hlp hta inf ins isp jse lnk mdb mde msc msi msp mst ocx pcd pif pot ppt sct shb shs sys url vb vbe vbs wsc wsf exe js vbs scr com bat wsh reg dll')) return true;
            break;

         default:
            this.error('"' + test + "\" test doesn't exist.");
            break;

		}
      
      return false;
      };

   }


var foul = new Foul();

