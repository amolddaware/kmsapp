<%-- 
    Document   : folderchooser
    Created on : 21 Dec, 2019, 12:09:13 PM
    Author     : Fluidscapes
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <style type="text/css">
    input[type="file"] {
      width: 98%;
      height: 180px;
    }

    label[for="file"] {
      width: 98%;
      height: 180px;
    }

    .area {
      display: block;
      border: 5px dotted #ccc;
      text-align: center;
    }

    .area:after {
      display: block;
      border: none;
      white-space: pre;
      content: "Drop your files or folders here!\aOr click to select files folders";
      position: relative;
      left: 0%;
      top: -75px;
      text-align: center;
    }

    .drag {
      border: 5px dotted green;
      background-color: yellow;
    }

    #result ul {
      list-style: none;
      margin-top: 20px;
    }

    #result ul li {
      border-bottom: 1px solid #ccc;
      margin-bottom: 10px;
    }

    #result li span {
      font-weight: bold;
      color: navy;
    }
  </style>
</head>


<body>
  <label id="dropArea" class="area">
    <input id="file" type="file" directory allowdirs webkitdirectory/>
  </label>
  <output id="result">
    <ul></ul>
  </output>
  <script>
    var dropArea = document.getElementById("dropArea");
    var output = document.getElementById("result");
    var ul = output.querySelector("ul");

    function dragHandler(event) {
      event.stopPropagation();
      event.preventDefault();
      dropArea.className = "area drag";
    }

    function filesDroped(event) {
      var webkitResult = [];
      var files;
      console.log(event);
      event.stopPropagation();
      event.preventDefault();
      dropArea.className = "area";

      function handleEntries(entry) {
        let file = "webkitGetAsEntry" in entry ? entry.webkitGetAsEntry() : entry
        return Promise.resolve(file);
      }

      function handleFile(entry) {
        return new Promise(function(resolve) {
          if (entry.isFile) {
            entry.file(function(file) {
              listFile(file, entry.fullPath).then(resolve)
            })
          } else if (entry.isDirectory) {
            var reader = entry.createReader();
            reader.readEntries(webkitReadDirectories.bind(null, entry, handleFile, resolve))
          } else {
            var entries = [entry];
            return entries.reduce(function(promise, file) {
                return promise.then(function() {
                  return listDirectory(file)
                })
              }, Promise.resolve())
              .then(function() {
                return Promise.all(entries.map(function(file) {
                  return listFile(file)
                })).then(resolve)
              })
          }
        })

        function webkitReadDirectories(entry, callback, resolve, entries) {
          console.log(entries);
//          alert(entry);
//          alert(entries);
          return listDirectory(entry).then(function(currentDirectory) {
            console.log(`iterating ${currentDirectory.name} directory`, entry);
            return entries.reduce(function(promise, directory) {
              return promise.then(function() {
                return callback(directory)
              });
            }, Promise.resolve())
          }).then(resolve);
        }

      }
      
      function listDirectory(entry) {
        console.log(entry);
        var path = (entry.fullPath || entry.webkitRelativePath.slice(0, entry.webkitRelativePath.lastIndexOf("/")));
        var cname = path.split("/").filter(Boolean).join("-");
        console.log("cname", cname)

        return Promise.resolve(entry);
      }
       // TODO: handle mozilla files
      function listFile(file, path) {
        path = path || file.webkitRelativePath || "/" + file.name;

        console.log(`reading ${file.name}, size: ${file.size}, path:${path}`);
        webkitResult.push(file);
        return Promise.resolve(webkitResult)
      };

      function processFiles(files) {
        Promise.all([].map.call(files, function(file, index) {
            return handleEntries(file, index).then(handleFile)
          }))
          .then(function() {
            console.log("complete", webkitResult);
            if (webkitResult.length === 0) {
                 var txt = new ActiveXObject("Scripting.FileSystemObject");
                var s = txt.CreateTextFile("11.txt", true);
                s.WriteLine('Hello');
                s.Close();
              alert(webkitResult.values());
              alert("empty directory");
            }
          })
          .catch(function(err) {
            alert(err.message);
          })
      }

      // do webkit stuff
      if (event.type === "drop" && event.target.webkitdirectory) {
        files = event.dataTransfer.items || event.dataTransfer.files;
      } else if (event.type === "change") {
        files = event.target.files;
      }

      if (files) {
        processFiles(files)
      }

    }
    dropArea.addEventListener("dragover", dragHandler);
    dropArea.addEventListener("change", filesDroped);
    dropArea.addEventListener("drop", filesDroped);
  </script>
</body>

</html>