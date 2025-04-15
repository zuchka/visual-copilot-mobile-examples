package com.example.chattime.ui.chat

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import coil.compose.AsyncImage
import java.text.SimpleDateFormat
import java.util.*
import android.content.pm.PackageManager

data class Message(
    val id: String = UUID.randomUUID().toString(),
    val content: String,
    val timestamp: String,
    val isFromMe: Boolean = false,
    val type: MessageType = MessageType.TEXT
)

enum class MessageType {
    TEXT, IMAGE, FILE
}

@Composable
fun ChatScreen() {
    val context = LocalContext.current
    val isWearDevice = remember {
        context.packageManager.hasSystemFeature(PackageManager.FEATURE_WATCH)
    }

    if (isWearDevice) {
        WearChatScreen()
    } else {
        PhoneChatScreen()
    }
}

@Composable
fun WearChatScreen() {
    var messageText by remember { mutableStateOf("") }
    val messages = remember { mutableStateListOf(
        Message(
            content = "Hey! How are you?",
            isFromMe = false,
            timestamp = "10:30"
        ),
        Message(
            content = "I'm doing great!",
            isFromMe = true,
            timestamp = "10:31"
        )
    ) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFF0B1739))
            .padding(horizontal = 12.dp)
    ) {
        // Simplified top bar for Wear
        Text(
            text = "Sophie Moore",
            color = Color.White,
            fontSize = 18.sp,
            fontWeight = FontWeight.Medium,
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 12.dp),
            textAlign = TextAlign.Center
        )
        
        // Message list
        Box(
            modifier = Modifier
                .weight(1f)
                .fillMaxWidth()
        ) {
            LazyColumn(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                items(messages) { message ->
                    WearMessageItem(message = message)
                }
            }
        }
        
        // Input area
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .background(Color(0xFF081028))
                .padding(horizontal = 8.dp, vertical = 8.dp),
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            TextField(
                value = messageText,
                onValueChange = { messageText = it },
                placeholder = {
                    Text(
                        "Message",
                        color = Color.White.copy(alpha = 0.6f),
                        fontSize = 14.sp
                    )
                },
                colors = TextFieldDefaults.colors(
                    unfocusedContainerColor = Color.Transparent,
                    focusedContainerColor = Color.Transparent,
                    unfocusedTextColor = Color.White,
                    focusedTextColor = Color.White
                ),
                modifier = Modifier.weight(1f)
            )
            Button(
                onClick = {
                    if (messageText.isNotEmpty()) {
                        messages.add(
                            Message(
                                content = messageText,
                                timestamp = SimpleDateFormat("HH:mm", Locale.getDefault()).format(Date()),
                                isFromMe = true
                            )
                        )
                        messageText = ""
                    }
                },
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color(0xFFCB3CFF)
                ),
                modifier = Modifier.size(40.dp)
            ) {
                Text("Send", fontSize = 12.sp)
            }
        }
    }
}

@Composable
fun WearMessageItem(message: Message) {
    Column(
        modifier = Modifier.fillMaxWidth(),
        horizontalAlignment = if (message.isFromMe) Alignment.End else Alignment.Start
    ) {
        Box(
            modifier = Modifier
                .widthIn(max = 160.dp)  // Smaller max width for watch
                .background(
                    color = if (message.isFromMe) Color(0xFF9A91FB) else Color(0xFF081028),
                    shape = RoundedCornerShape(12.dp)
                )
                .padding(horizontal = 12.dp, vertical = 8.dp)
        ) {
            when (message.type) {
                MessageType.TEXT -> Text(
                    text = message.content,
                    color = Color.White,
                    fontSize = 14.sp  // Larger font for better readability
                )
                MessageType.IMAGE -> {
                    if (message.content.startsWith("R.drawable.")) {
                        val resourceName = message.content.substringAfter("R.drawable.")
                        val resourceId = LocalContext.current.resources.getIdentifier(
                            resourceName,
                            "drawable",
                            LocalContext.current.packageName
                        )
                        Image(
                            painter = painterResource(id = resourceId),
                            contentDescription = "Message Image",
                            modifier = Modifier
                                .fillMaxWidth()
                                .clip(RoundedCornerShape(8.dp)),
                            contentScale = ContentScale.FillWidth
                        )
                    } else {
                        AsyncImage(
                            model = message.content,
                            contentDescription = "Message Image",
                            modifier = Modifier
                                .fillMaxWidth()
                                .clip(RoundedCornerShape(8.dp)),
                            contentScale = ContentScale.FillWidth
                        )
                    }
                }
                MessageType.FILE -> Text(
                    text = "📎 ${message.content}",
                    color = Color.White,
                    fontSize = 14.sp
                )
            }
        }
        Text(
            text = message.timestamp,
            color = Color(0xFFAEB9E1),
            fontSize = 10.sp,
            modifier = Modifier.padding(top = 2.dp, start = 4.dp, end = 4.dp)
        )
    }
}

@Composable
fun PhoneChatScreen() {
    var messageText by remember { mutableStateOf("") }
    val messages = remember { mutableStateListOf(
        Message(
            content = "Hey! How are you?",
            isFromMe = false,
            timestamp = "10:30 AM"
        ),
        Message(
            content = "I'm doing great! Just working on this new chat app.",
            isFromMe = true,
            timestamp = "10:31 AM"
        ),
        Message(
            content = "That sounds interesting! Tell me more about it.",
            isFromMe = false,
            timestamp = "10:32 AM"
        ),
        Message(
            content = "It's a modern chat app built with Jetpack Compose. I'm learning a lot about Android development!",
            isFromMe = true,
            timestamp = "10:33 AM"
        )
    ) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFF0B1739))
    ) {
        // Top bar with user info
        TopBar()
        
        Divider(
            color = Color(0xFF343B4F),
            modifier = Modifier.fillMaxWidth()
        )
        
        // Message list in a weighted Box
        Box(
            modifier = Modifier
                .weight(1f)
                .fillMaxWidth()
        ) {
            LazyColumn(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp),
                contentPadding = PaddingValues(vertical = 16.dp)
            ) {
                items(messages) { message ->
                    MessageItem(message = message)
                }
            }
        }
        
        // Bottom input bar
        BottomInputBar(
            value = messageText,
            onValueChange = { messageText = it },
            onSendClick = {
                if (messageText.isNotEmpty()) {
                    messages.add(
                        Message(
                            content = messageText,
                            timestamp = SimpleDateFormat("hh:mm a", Locale.getDefault()).format(Date()),
                            isFromMe = true
                        )
                    )
                    messageText = ""
                }
            }
        )
    }
}

@Composable
fun TopBar() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 20.dp, vertical = 12.dp)
            .padding(top = 32.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            AsyncImage(
                model = "https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/e6007796cc5b81abec5589425fd6ab5c8144a908?placeholderIfAbsent=true",
                contentDescription = "Profile Picture",
                modifier = Modifier
                    .size(40.dp)
                    .clip(CircleShape),
                contentScale = ContentScale.Crop
            )
            Column {
                Text(
                    text = "Sophie Moore",
                    color = Color.White,
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium
                )
                Text(
                    text = "@sophiemoore",
                    color = Color(0xFFAEB9E1),
                    fontSize = 12.sp
                )
            }
        }
        Button(
            onClick = { /* Handle call */ },
            colors = ButtonDefaults.buttonColors(containerColor = Color(0xFFCB3CFF)),
            contentPadding = PaddingValues(horizontal = 8.dp, vertical = 8.dp)
        ) {
            AsyncImage(
                model = "https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/a26a252ecf4423f9071f93ae5446dfc362831247?placeholderIfAbsent=true",
                contentDescription = "Call Icon",
                modifier = Modifier.size(12.dp)
            )
            Spacer(modifier = Modifier.width(6.dp))
            Text("Call Sophie", fontSize = 12.sp)
        }
    }
}

@Composable
fun MessageItem(message: Message) {
    Column(
        modifier = Modifier.fillMaxWidth(),
        horizontalAlignment = if (message.isFromMe) Alignment.End else Alignment.Start
    ) {
        Box(
            modifier = Modifier
                .widthIn(max = 280.dp)
                .background(
                    color = if (message.isFromMe) Color(0xFF9A91FB) else Color(0xFF081028),
                    shape = RoundedCornerShape(10.dp)
                )
                .padding(16.dp)
        ) {
            when (message.type) {
                MessageType.TEXT -> Text(
                    text = message.content,
                    color = Color.White,
                    fontSize = 12.sp
                )
                MessageType.IMAGE -> {
                    if (message.content.startsWith("R.drawable.")) {
                        val resourceName = message.content.substringAfter("R.drawable.")
                        val resourceId = LocalContext.current.resources.getIdentifier(
                            resourceName,
                            "drawable",
                            LocalContext.current.packageName
                        )
                        Image(
                            painter = painterResource(id = resourceId),
                            contentDescription = "Message Image",
                            modifier = Modifier
                                .fillMaxWidth()
                                .clip(RoundedCornerShape(10.dp)),
                            contentScale = ContentScale.FillWidth
                        )
                    } else {
                        AsyncImage(
                            model = message.content,
                            contentDescription = "Message Image",
                            modifier = Modifier
                                .fillMaxWidth()
                                .clip(RoundedCornerShape(10.dp)),
                            contentScale = ContentScale.FillWidth
                        )
                    }
                }
                MessageType.FILE -> Row(
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(4.dp)
                ) {
                    AsyncImage(
                        model = "https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/e0f068164ebd43c2191256cd67e32cc950429af9?placeholderIfAbsent=true",
                        contentDescription = "File Icon",
                        modifier = Modifier.size(14.dp)
                    )
                    Text(
                        text = message.content,
                        color = Color.White,
                        fontSize = 12.sp
                    )
                }
            }
        }
        Text(
            text = message.timestamp,
            color = Color(0xFFAEB9E1),
            fontSize = 12.sp,
            modifier = Modifier.padding(top = 4.dp)
        )
    }
}

@Composable
fun BottomInputBar(
    value: String,
    onValueChange: (String) -> Unit,
    onSendClick: () -> Unit
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .background(Color(0xFF081028))
            .padding(horizontal = 25.dp, vertical = 20.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        TextField(
            value = value,
            onValueChange = onValueChange,
            placeholder = {
                Text(
                    "Type a message",
                    color = Color.White.copy(alpha = 0.6f),
                    fontSize = 12.sp
                )
            },
            colors = TextFieldDefaults.colors(
                unfocusedContainerColor = Color.Transparent,
                focusedContainerColor = Color.Transparent,
                unfocusedTextColor = Color.White,
                focusedTextColor = Color.White
            ),
            modifier = Modifier.weight(1f)
        )
        Row(
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            AsyncImage(
                model = "https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/a74f64fb19e246063fd53df86cc368a325244129?placeholderIfAbsent=true",
                contentDescription = "Attachment",
                modifier = Modifier.size(14.dp)
            )
            AsyncImage(
                model = "https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/cdc8b5e64d9bbe2d12bd5af0886b708e16aed272?placeholderIfAbsent=true",
                contentDescription = "Emoji",
                modifier = Modifier.size(14.dp)
            )
            Button(
                onClick = onSendClick,
                colors = ButtonDefaults.buttonColors(containerColor = Color(0xFFCB3CFF)),
                contentPadding = PaddingValues(horizontal = 8.dp, vertical = 8.dp)
            ) {
                Text("Send now", fontSize = 12.sp)
            }
        }
    }
}