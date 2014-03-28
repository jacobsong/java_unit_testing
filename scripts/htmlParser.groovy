def String exe(String exec) {
	sout = new StringBuffer()
	serr = new StringBuffer()
	command = exec.execute()
	command.consumeProcessOutput(sout,serr)
	command.waitFor()
	return sout.toString()
}


inputFile = new File(args[0])
outputFile = new File(args[1])

outputFile.append("<html><head></head><body>")
outputFile.append("<h1>Test Results</h1>")
outputFile.append("<h3>Test date: "+exe("date")+"</h3>")
outputFile.append("<table border=\"1\" width=\"300\">")

dataArray = [new ArrayList(), new ArrayList(), new ArrayList(), new ArrayList(), new ArrayList(), new ArrayList(), new ArrayList(), new ArrayList()]
outputFile.append("<tr>\n")
headerArray = ["TEST NUMBER","REQUIREMENTS","COMPNONENT BEING TESTED","METHOD NAME","INPUT","EXPECTED OUTPUT","ACTUAL OUTPUT","RESULT"]
headerArray.each() { outputFile.append("<td><b>"+it+"</b></td>\n") }
outputFile.append("</tr>\n")

searchArray = ["TEST NUMBER", "REQUIRE", "COMPON", "METHOD", "INPUT", "EXPECTED", "ACTUAL", "RESULT"]
for (int i = 0; i<8; i++) {
	inputFile.eachLine() { line ->
		if (line.contains(searchArray[i])) {
			if (!line.split(":")[1].equals(" ")) {
				dataArray[i].add(line.split(":")[1])
			}
			else {
				dataArray[i].add("<NO OUTPUT>")
			}
		}
	}
}
for (int i = 0; i < dataArray[0].size(); i++) {
	outputFile.append("<tr>\n")
	for (int j = 0; j < 8; j++) {
		 outputFile.append("<td>"+dataArray[j][i]+"</td>\n")
	}
	outputFile.append("</tr>")
}
outputFile.append("</table></body></html>")
browserOpen = "firefox ../reports/report.html".execute()

