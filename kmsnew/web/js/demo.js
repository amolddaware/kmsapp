
$(function () {
    skinChanger();
    activateNotificationAndTasksScroll();

    setSkinListHeightAndScroll(true);
    setSettingListHeightAndScroll(true);
    $(window).resize(function () {
        setSkinListHeightAndScroll(false);
        setSettingListHeightAndScroll(false);
    });
});

//Skin changer
function skinChanger() {
    $('.right-sidebar .demo-choose-skin li').on('click', function () {
        var $body = $('body');
        var $this = $(this);

        var existTheme = $('.right-sidebar .demo-choose-skin li.active').data('theme');
        $('.right-sidebar .demo-choose-skin li').removeClass('active');
        $body.removeClass('theme-' + existTheme);
        $this.addClass('active');

        $body.addClass('theme-' + $this.data('theme'));
    });
}

//Skin tab content set height and show scroll
function setSkinListHeightAndScroll(isFirstTime) {
    var height = $(window).height() - ($('.navbar').innerHeight() + $('.right-sidebar .nav-tabs').outerHeight());
    var $el = $('.demo-choose-skin');

    if (!isFirstTime) {
        $el.slimScroll({destroy: true}).height('auto');
        $el.parent().find('.slimScrollBar, .slimScrollRail').remove();
    }

    $el.slimscroll({
        height: height + 'px',
        color: 'rgba(0,0,0,0.5)',
        size: '6px',
        alwaysVisible: false,
        borderRadius: '0',
        railBorderRadius: '0'
    });
}

//Setting tab content set height and show scroll
function setSettingListHeightAndScroll(isFirstTime) {
    var height = $(window).height() - ($('.navbar').innerHeight() + $('.right-sidebar .nav-tabs').outerHeight());
    var $el = $('.right-sidebar .demo-settings');

    if (!isFirstTime) {
        $el.slimScroll({destroy: true}).height('auto');
        $el.parent().find('.slimScrollBar, .slimScrollRail').remove();
    }

    $el.slimscroll({
        height: height + 'px',
        color: 'rgba(0,0,0,0.5)',
        size: '6px',
        alwaysVisible: false,
        borderRadius: '0',
        railBorderRadius: '0'
    });
}

//Activate notification and task dropdown on top right menu
function activateNotificationAndTasksScroll() {
    $('.navbar-right .dropdown-menu .body .menu').slimscroll({
        height: '254px',
        color: 'rgba(0,0,0,0.5)',
        size: '4px',
        alwaysVisible: false,
        borderRadius: '0',
        railBorderRadius: '0'
    });
}

//Google Analiytics ======================================================================================
//addLoadEvent(loadTracking);
//var trackingId = 'UA-30038099-6';
//
//function addLoadEvent(func) {
//    var oldonload = window.onload;
//    if (typeof window.onload != 'function') {
//        window.onload = func;
//    } else {
//        window.onload = function () {
//            oldonload();
//            func();
//        }
//    }
//}
//
//function loadTracking() {
//    (function (i, s, o, g, r, a, m) {
//        i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
//            (i[r].q = i[r].q || []).push(arguments)
//        }, i[r].l = 1 * new Date(); a = s.createElement(o),
//        m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
//    })(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');
//
//    ga('create', trackingId, 'auto');
//    ga('send', 'pageview');
//}
//========================================================================================================

//Drag N Drop Code 

function sendFileToServer(formData, status)
{
//                                alert(status);
    var uploadURL = "newsdragndrop.do"; //Upload URL
    //    var uploadURL ="http://hayageek.com/examples/jquery/drag-drop-file-upload/upload.php"; //Upload URL
    var extraData = {}; //Extra Data.
    var jqXHR = $.ajax({
        xhr: function () {
            var xhrobj = $.ajaxSettings.xhr();
            if (xhrobj.upload) {
                xhrobj.upload.addEventListener('progress', function (event) {
                    var percent = 0;
                    var position = event.loaded || event.position;
                    var total = event.total;
                    if (event.lengthComputable) {
                        percent = Math.ceil(position / total * 100);
                    }
                    //                                                                                                alert(percent);

                    //Set progress
                    status.setProgress(percent);
                    if (percent == 100) {
                        document.getElementById("btnSaveVideo").disabled = false;
                        //                                                                                                    document.getElementById("btnSaveVideo").style.visibility = "visible";
                        //                                                                                                    var element = document.getElementById("btnSaveVideo");
                        //                                                                                                    element.classList.add("text-center");

                    }
                }, false);
            }
            //                                                                                        alert();
            return xhrobj;
        },
        url: uploadURL,
        type: "POST",
        contentType: false,
        processData: false,
        cache: false,
        data: formData,
        success: function (data) {
//            alert(data);
            var ddd = data;
            var dddd = ddd.split(",");
//            alert(dddd[0]);
            //                                                                                        alert(ddd[1]);
            //                                                                                        
            //this.filename=ddd[1];
            //var present_value = $( "#progressbar" ).progressbar( "option", "value" );
            //alert($("#progressbar").progressbar("value"));
            if (dddd[0] == "exist") {
//                alert(dddd[1]);
                document.getElementById("displayAvailable").style.display = "block";
                document.getElementById("showExist").innerHTML = "The '" + dddd[1] + "' file already exist. Please choose different file";
            }
        }
    });

    status.setAbort(jqXHR);
}

var rowCount = 0;
function createStatusbar(obj)
{
    document.getElementById("uploadstatus").value = "test";
//                    document.getElementById("errDragnDrop").innerHTML = "";
    rowCount++;
    var row = "odd";
    if (rowCount % 2 == 0)
        row = "even";
    //                   this.filename=$("#status");
    this.statusbar = $("<div class='statusbar " + row + "'></div>");
    this.filename = $("<div id='filename'   class='filename'></div>").appendTo(this.statusbar);
    this.size = $("<div class='filesize'></div>").appendTo(this.statusbar);
    this.progressBar = $("<div class='progressBar' id='progressbar'><div></div></div>").appendTo(this.statusbar);
    //                                                                                this.abort = $("<div class='abort'>Remove</div>").appendTo(this.statusbar);
    obj.after(this.statusbar);

    this.setFileNameSize = function (name, size)
    {
        document.getElementById("tempvideo").value = name;
        var n = 0;
        var sizeStr = "";
        var sizeKB = size / 1024;
        if (parseInt(sizeKB) > 1024)
        {
            var sizeMB = sizeKB / 1024;
            sizeStr = sizeMB.toFixed(2) + " MB";
        } else
        {
            sizeStr = sizeKB.toFixed(2) + " KB";
        }

        var full = name.split("[");

        //                                                                                    alert(full[0]+" "+full[1]);
        var chname = full[0].split("_");
        //                                                                                    alert(chname[1]);
        var outString = full[1].replace(/[`~!@#$%^&*()|+\=?;:_'", <>\{\}\[\]\\\-/]/gi, '');
        var ssss = chname[1].trim() + "_" + outString;
        //                                                                                    alert(chname[1]+"_"+outString);
        //                                                                                    var chdate=outString.replace('-','');
        //                                                                                    alert(chdate);
        var ss = ssss.replace('..', '_');

        document.getElementById("newFilename").value = ss;
        //                                                                                 var ss=chname[1]+"_"+outString
        //                                                                                    alert(ss);
        //                                                                                    var xy=ss.replcae("")
        //                                                                                    var fulldate = dd + "-" + mm + "-" + yy;
        //                                                                                    alert(dd);
        this.filename.html(ss);
        //                                                                                    this.filename.html(fulldate + "_" + name);
        this.size.html(sizeStr);
    }
    this.setProgress = function (progress)
    {
        var progressBarWidth = progress * this.progressBar.width() / 100;
        this.progressBar.find('div').animate({width: progressBarWidth}, 10).html(progress + "% ");
        if (parseInt(progress) >= 100)
        {
            //                                                                                        this.abort.hide();
        }
    }
    this.setAbort = function (jqxhr)
    {
        var sb = this.statusbar;
        this.abort.click(function ()
        {
            jqxhr.abort();
            //                                                                                        alert("hi");
            //                                                                                        sb.hide();
            sb.remove();
        });
    }
}
//                                                                            function abortData()
function handleFileUpload(files, obj)
{
    var counter = 0;
    var filename;
    for (var i = 0; i < files.length; i++)
    {
        //                             
        //                alert("gfddff");
//        if (files[i].type != "video/mp4") {
//            //    alert("wrong");
//            document.getElementById("displayFileFormat").style.display = "block";
//        } else {

            //                alert("adada");                                                                                                                                                                                                                                                alert("filenansmmsm:-"+files[i].name);
            var fd = new FormData();
            fd.append('file', files[i]);

            var status = new createStatusbar(obj); //Using this we can set progress.
            status.setFileNameSize(files[i].name, files[i].size);

            sendFileToServer(fd, status);
//        }

    }
}
$(document).ready(function ()
{
    var obj = $("#dragandrophandler1");
    obj.on('dragenter', function (e)
    {
        e.stopPropagation();
        e.preventDefault();
        $(this).css('border', '2px solid #0B85A1');
    });
    obj.on('dragover', function (e)
    {
        e.stopPropagation();
        e.preventDefault();
    });
    obj.on('drop', function (e)
    {
//                        alert("hhhh");
        $(this).css('border', '2px dotted #0B85A1');
        e.preventDefault();
        var files = e.originalEvent.dataTransfer.files;

        //We need to send dropped files to Server
        handleFileUpload(files, obj);
    });
    $(document).on('dragenter', function (e)
    {
        e.stopPropagation();
        e.preventDefault();
    });
    $(document).on('dragover', function (e)
    {
        e.stopPropagation();
        e.preventDefault();
        obj.css('border', '2px dotted #0B85A1');
    });
    $(document).on('drop', function (e)
    {
        e.stopPropagation();
        e.preventDefault();
    });

});

$(document).ready(function () {
    var seen = {};

                $('.npnameH3').each(function () {
                    var txt = $(this).text();
                    if (seen[txt])
                        $(this).remove();
                    else
                        seen[txt] = true;
                });
                $('.eleName').each(function () {
                    var txt = $(this).text();
                    if (seen[txt])
                        $(this).remove();
                    else
                        seen[txt] = true;
                });
                $('.priName').each(function () {
                    var txt = $(this).text();
                    if (seen[txt])
                        $(this).remove();
                    else
                        seen[txt] = true;
                });
                $('.digName').each(function () {
                    var txt = $(this).text();
                    if (seen[txt])
                        $(this).remove();
                    else
                        seen[txt] = true;
                });
                $('.grName').each(function () {
                    var txt = $(this).text();
                    if (seen[txt])
                        $(this).remove();
                    else
                        seen[txt] = true;
                });
                $('.crName').each(function () {
                    var txt = $(this).text();
                    if (seen[txt])
                        $(this).remove();
                    else
                        seen[txt] = true;
                });
//                var seen1 = {};
//                $('.npnameImg').each(function () {
//                    var txt = $(this).attr("src");
//                    if (seen1[txt])
//                        $(this).remove();
//                    else
//                        seen1[txt] = true;
//                });
 
    var seen1 = {};
    /*
    $('.npnameImg').each(function (i) {
        var txt = $(this).attr("src");

        if (seen1[txt]) {
            $(this).remove();
//                    $(".hrdotted").addClass("hr_dotted");
        } else {
            seen1[txt] = true;
            if ($(this).is(':last-child')) {
                // Your code here
                //$(this).before("<div class='col-md-12 brImg'><img class='img-responsive ' src='images/border.png'/></div>");
            }
        }

//                
    });
*/
//                $(function () {
    function split(val) {
        return val.split(/,\s*/);
    }
    function extractLast(term) {
        return split(term).pop();
    }

    $("#sourceid").autocomplete({
        source: function (request, response) {
//            alert("tee");
            $.getJSON("dm_jsonfile_source.jsp?description=" + document.getElementById("sourceid").value, {
                term: extractLast(request.term)
            }, response);
        },
        search: function () {
            // custom minLength
            var term = extractLast(this.value);
//                                           alert(term);
            if (term.length < 2) {

                return false;
            }
        }
    });
    $("#topicid").autocomplete({
        source: function (request, response) {
//                    alert("tee");
            $.getJSON("dm_jsonfile_topic.jsp?description=" + document.getElementById("topicid").value, {
                term: extractLast(request.term)
            }, response);
        },
        search: function () {
            // custom minLength
            var term = extractLast(this.value);
//                                           alert(term);
            if (term.length < 2) {

                return false;
            }
        }
    });
    $("#generaltag")
//                $("#generalTag1 input")
            .autocomplete({
                source: function (request, response) {
//                                alert("tee");
                    $.getJSON("jsonfile_1.jsp?description=" + document.getElementById("generaltag").value, {
                        term: extractLast(request.term)
                    }, response);
                },
                search: function () {
                    // custom minLength
                    var term = extractLast(this.value);
//                                           alert(term);
                    if (term.length < 2) {

                        return false;
                    }
                }
            });
    $("#locationid")
            .autocomplete({
                source: function (request, response) {
//                                alert("tee");
                    $.getJSON("pr_jsonfile_location.jsp?description=" + document.getElementById("locationid").value, {
                        term: extractLast(request.term)
                    }, response);
                },
                search: function () {
                    // custom minLength
                    var term = extractLast(this.value);
//                                alert(term);
                    if (term.length < 2) {

                        return false;
                    }
                }
            });
    $("#titleid")
            .autocomplete({
                source: function (request, response) {
//                                alert("tee");
                    $.getJSON("pr_jsonfile.jsp?description=" + document.getElementById("titleid").value, {
                        term: extractLast(request.term)
                    }, response);
                },
                search: function () {
                    // custom minLength
                    var term = extractLast(this.value);
//                                alert(term);
                    if (term.length < 2) {

                        return false;
                    }
                }
            });
    $("#titlecr")
            .autocomplete({
                source: function (request, response) {
//                                alert("tee");
                    $.getJSON("cr_jsonfile.jsp?description=" + document.getElementById("titlecr").value, {
                        term: extractLast(request.term)
                    }, response);
                },
                search: function () {
                    // custom minLength
                    var term = extractLast(this.value);
//                                alert(term);
                    if (term.length < 2) {

                        return false;
                    }
                }
            });
    $("#nameofprogramcr")
            .autocomplete({
                source: function (request, response) {
//                                alert("tee");
                    $.getJSON("cr_jsonfile_nameofprogram.jsp?description=" + document.getElementById("nameofprogramcr").value, {
                        term: extractLast(request.term)
                    }, response);
                },
                search: function () {
                    // custom minLength
                    var term = extractLast(this.value);
//                                alert(term);
                    if (term.length < 2) {

                        return false;
                    }
                }
            });
    $("#placeofprogramcr")
            .autocomplete({
                source: function (request, response) {
//                                alert("tee");
                    $.getJSON("cr_jsonfile_placeofprogram.jsp?description=" + document.getElementById("placeofprogramcr").value, {
                        term: extractLast(request.term)
                    }, response);
                },
                search: function () {
                    // custom minLength
                    var term = extractLast(this.value);
//                                alert(term);
                    if (term.length < 2) {

                        return false;
                    }
                }
            });
    $("#tagcr")
            .autocomplete({
                source: function (request, response) {
//                                alert("tee");
                    $.getJSON("cr_jsonfile_tagcr.jsp?description=" + document.getElementById("tagcr").value, {
                        term: extractLast(request.term)
                    }, response);
                },
                search: function () {
                    // custom minLength
                    var term = extractLast(this.value);
//                                alert(term);
                    if (term.length < 2) {

                        return false;
                    }
                }
            });
    $("#tagsid")
            .autocomplete({
                source: function (request, response) {
//                                alert("tee");
                    $.getJSON("pr_jsonfile_tags.jsp?description=" + document.getElementById("tagsid").value, {
                        term: extractLast(request.term)
                    }, response);
                },
                search: function () {
                    // custom minLength
                    var term = extractLast(this.value);
//                                alert(term);
                    if (term.length < 2) {

                        return false;
                    }
                }
            });
    $("#titlemarathiid")
            .autocomplete({
                source: function (request, response) {
//                                alert("tee");
                    $.getJSON("pr_jsonfile_marathi.jsp?description=" + document.getElementById("titlemarathiid").value, {
                        term: extractLast(request.term)
                    }, response);
                },
                search: function () {
                    // custom minLength
                    var term = extractLast(this.value);
//                                alert(term);
                    if (term.length < 2) {

                        return false;
                    }
                }
            });
    $("#titlemarathiidgr")
            .autocomplete({
                source: function (request, response) {
//                                alert("tee");
                    $.getJSON("gr_jsonfile_marathi.jsp?description=" + document.getElementById("titlemarathiidgr").value, {
                        term: extractLast(request.term)
                    }, response);
                },
                search: function () {
                    // custom minLength
                    var term = extractLast(this.value);
//                                alert(term);
                    if (term.length < 2) {

                        return false;
                    }
                }
            });
    $("#titleidgr")
            .autocomplete({
                source: function (request, response) {
//                                alert("tee");
                    $.getJSON("gr_jsonfile.jsp?description=" + document.getElementById("titleidgr").value, {
                        term: extractLast(request.term)
                    }, response);
                },
                search: function () {
                    // custom minLength
                    var term = extractLast(this.value);
//                                alert(term);
                    if (term.length < 2) {

                        return false;
                    }
                }
            });
    $("#generaltagcreative").autocomplete({
        source: function (request, response) {
//                    alert("tee");
            $.getJSON("cr_jsonfile.jsp?description=" + document.getElementById("generaltagcreative").value, {
                term: extractLast(request.term)
            }, response);
        },
        search: function () {
            // custom minLength
            var term = extractLast(this.value);
//                                           alert(term);
            if (term.length < 2) {

                return false;
            }
        }
    });
    $("#generaltagprint").autocomplete({
        source: function (request, response) {
//                    alert("tee");
            $.getJSON("pr_jsonfile.jsp?description=" + document.getElementById("generaltagprint").value, {
                term: extractLast(request.term)
            }, response);
        },
        search: function () {
            // custom minLength
            var term = extractLast(this.value);
//                                           alert(term);
            if (term.length < 2) {

                return false;
            }
        }
    });
    $("#generaltagdigital").autocomplete({
        source: function (request, response) {
//                    alert("tee");
            $.getJSON("dm_jsonfile.jsp?description=" + document.getElementById("generaltagdigital").value, {
                term: extractLast(request.term)
            }, response);
        },
        search: function () {
            // custom minLength
            var term = extractLast(this.value);
//                                           alert(term);
            if (term.length < 2) {

                return false;
            }
        }
    });
});

function saveData() {
    var aa = document.getElementById("newFilename").value;
//                alert(aa);
//                var aa = document.getElementsByClassName("filename");
    var abc;
    var subject = document.getElementById("subject").value;
    var titlemarathi = document.getElementById("titlemarathi").value;

    var description = document.getElementById("description").value;
    var sentiment = document.getElementById("sentiment").value;
    var tags = document.getElementById("tags").value;
    var uploadstatus = document.getElementById("uploadstatus").value;
    for (var i = 0; i < aa.length; i++) {
        abc += aa[i].textContent + ",\n";
//                    alert(aa[i].textContent);
//            if(abc!=""){       
        document.getElementById("textInput").value = abc;

    }

    if (subject == "") {
        document.getElementById("errSubject").innerHTML = "Please Enter Subject";
        document.getElementById("subject").focus();
        return false;
    }
    if (titlemarathi == "") {
        document.getElementById("errMarathiTitle").innerHTML = "Please Enter Title Marathi";
        document.getElementById("titlemarathi").focus();
        return false;
    }
    if (description == "") {
        document.getElementById("errDescription").innerHTML = "Please Enter Description";
        document.getElementById("description").focus();
        return false;
    }

    if (sentiment == "") {
        document.getElementById("errSentiment").innerHTML = "Please Select Sentiment";
        document.getElementById("sentiment").focus();
        return false;
    }
    if (tags == "" && $('#divAa:empty').length) {

        document.getElementById("errTag").style.display = "block";
        document.getElementById("errTag").innerHTML = "Please enter tags";
        document.getElementById("tags").focus();
//        document.getElementById("tags").focus();
        return false;
    }

    var node = document.getElementById('filename');

//htmlContent = node.innerHTML,
// htmlContent = "Some <span class="foo">sample</span> text."

    var textContent = node.textContent;
//    alert(textContent);
    if (uploadstatus != "test") {
        document.getElementById("errDragnDrop").innerHTML = "Please upload files";
        document.getElementById("dragndrophandler").focus();
        return false;
    }
    var a = document.getElementById("divAa").innerHTML;
//                alert(a);
    document.getElementById("tags").value = a;

    document.getElementById("uploadform").submit();

}

function errorBlank(err) {
    document.getElementById(err).innerHTML = "";
}

 