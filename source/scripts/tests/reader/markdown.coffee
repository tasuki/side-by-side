test("markdownReader", () ->
    injector = angular.injector(["ng", "sideBySide"])
    markDownReader = injector.get("markdownReader")

    testCases = [{
        tested: """
            Title: Universal Declaration of Human Rights
            Author: John Peters Humphrey
            Date: 1948
            Source: http://en.wikisource.org/wiki/Universal_Declaration_of_Human_Rights

            ## 1
            All human beings are born *free* and equal in dignity and rights...

            ## 2
            Everyone is entitled to all the rights and freedoms...

            Furthermore, no distinction shall be made on the basis of...

            ## 11.1
            Everyone charged with a penal offence has the right to be presumed...

            ## 11.2
            No one shall be held guilty of any penal offence...

            ## 13
            Everyone is entitled to:

            - sex
            - drugs
            - rock & roll
            """
        expected: {
            meta: {
                Title: "Universal Declaration of Human Rights"
                Author: "John Peters Humphrey"
                Date: "1948"
                Source: '<a href="http://en.wikisource.org/wiki/Universal_Declaration_of_Human_Rights">http://en.wikisource.org/wiki/Universal_Declaration_of_Human_Rights</a>'
            }
            content: [
                { section: "1", text: "<p>All human beings are born <em>free</em> and equal in dignity and rights...</p>\n" }
                { section: "2", text: """<p>Everyone is entitled to all the rights and freedoms...</p>
                                         <p>Furthermore, no distinction shall be made on the basis of...</p>\n""" }
                { section: "11.1", text: "<p>Everyone charged with a penal offence has the right to be presumed...</p>\n" }
                { section: "11.2", text: "<p>No one shall be held guilty of any penal offence...</p>\n" }
                { section: "13", text: """<p>Everyone is entitled to:</p>
                                          <ul>
                                          <li>sex</li>
                                          <li>drugs</li>
                                          <li>rock &amp; roll</li>
                                          </ul>\n""" }
            ]
        }
    }, {
        tested: """
            Title: Test leading text

            **This** is leading text.
            # I
            First section.
            # II
            Second section.
            """
        expected: {
            meta: {
                Title: "Test leading text"
            }
            content: [
                { section: "", text: "<p><strong>This</strong> is leading text.</p>\n" }
                { section: "I", text: "<p>First section.</p>\n" }
                { section: "II", text: "<p>Second section.</p>\n" }
            ]
        }
    }]

    for testCase in testCases
        deepEqual(markDownReader(testCase.tested), testCase.expected)
)
