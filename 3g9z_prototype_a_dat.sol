pragma solidity ^0.8.0;

contract ChatbotSimulator {
    struct ConversationalContext {
        string userQuery;
        string[] conversationHistory;
        string chatbotResponse;
    }

    mapping (address => ConversationalContext) public contextualData;

    function initiateConversation(string memory _userQuery) public {
        ConversationalContext storage context = contextualData[msg.sender];
        context.userQuery = _userQuery;
        context.conversationHistory.push(_userQuery);
    }

    function respondToUser(string memory _chatbotResponse) public {
        ConversationalContext storage context = contextualData[msg.sender];
        context.chatbotResponse = _chatbotResponse;
        context.conversationHistory.push(_chatbotResponse);
    }

    function retrieveConversationHistory() public view returns (string[] memory) {
        ConversationalContext storage context = contextualData[msg.sender];
        return context.conversationHistory;
    }

    function testConversationFlow() public {
        initiateConversation("What is the weather like today?");
        respondToUser("It's sunny and 25°C in your area.");
        initiateConversation("That's great! Will it rain tomorrow?");
        respondToUser("There's a 30% chance of light rain showers tomorrow.");
        string[] memory conversation = retrieveConversationHistory();
        assert(conversation.length == 4);
    }
}