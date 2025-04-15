package com.example.chattime.ui.chat

import androidx.lifecycle.ViewModel
import androidx.compose.runtime.mutableStateListOf
import java.text.SimpleDateFormat
import java.util.*

class ChatViewModel : ViewModel() {
    private val _messages = mutableStateListOf<Message>()
    val messages: List<Message> = _messages

    init {
        // Add initial messages
        addMessage(Message(
            content = "Hey! How are you?",
            isFromMe = false,
            timestamp = "10:30 AM"
        ))
        addMessage(Message(
            content = "I'm doing great! Just working on this new chat app.",
            isFromMe = true,
            timestamp = "10:31 AM"
        ))
    }

    fun addMessage(message: Message) {
        _messages.add(message)
    }

    fun sendMessage(content: String) {
        val timestamp = SimpleDateFormat("hh:mm a", Locale.getDefault()).format(Date())
        val message = Message(
            content = content,
            timestamp = timestamp,
            isFromMe = true
        )
        addMessage(message)
    }
} 