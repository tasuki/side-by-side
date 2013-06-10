test("jsonReader", () ->
    injector = angular.injector(["ng", "sideBySide"])
    jsonReader = injector.get("jsonReader")

    testCases = [{
        tested: """
            {
                meta: {
                    Title: "Test leading text"
                },
                content: [
                    "<p><strong>This</strong> is leading text.</p>",
                    { section: "I", text: "<p>First section.</p>" },
                    { section: "II", text: "<p>Second section.</p>" },
                    { text: "<p>Another section.</p>" },
                ],
            }"""
        expected: {
            meta: {
                Title: "Test leading text"
            }
            content: [
                { section: "", text: "<p><strong>This</strong> is leading text.</p>" }
                { section: "I", text: "<p>First section.</p>" }
                { section: "II", text: "<p>Second section.</p>" }
                { section: "", text: "<p>Another section.</p>" }
            ]
        }
    }]

    for testCase in testCases
        deepEqual(jsonReader(testCase.tested), testCase.expected)
)
