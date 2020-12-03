import com.kcc.kmmhackathon.shared.entity.FirebaseAuthenticationResponse
import io.ktor.client.HttpClient
import io.ktor.client.features.*
import io.ktor.client.request.*
import io.ktor.client.statement.HttpStatement
import io.ktor.client.statement.readText
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import kotlinx.serialization.json.Json
import io.ktor.http.*

class FirebaseAuthenticationStore : AuthenticationStore {

    private val httpClient = HttpClient {
        install(JsonFeature) {
            val json = Json { ignoreUnknownKeys = true }
            serializer = KotlinxSerializer(json)
        }
    }

    override suspend fun signUp(
        email: String,
        password: String,
        returnSecureToken: Boolean
    ) = handleAuthenticationRequest( apiKey, ENDPOINT_SIGN_UP, email, password, returnSecureToken )

    override suspend fun signIn(
        email: String,
        password: String,
        returnSecureToken: Boolean
    ) = handleAuthenticationRequest( apiKey, ENDPOINT_SIGN_IN, email, password, returnSecureToken )

    private suspend fun handleAuthenticationRequest(
        endpoint: String,
        email: String,
        password: String,
        returnSecureToken: Boolean
    ): FirebaseAuthenticationResponse {
        return try {
            httpClient.post {
                url("$BASE_URL$endpoint")
                parameter("key", "")
                parameter("email", email)
                parameter("password", password)
                parameter("returnSecureToken", returnSecureToken)
            }
        } catch (cause: Throwable) {
            FirebaseAuthenticationResponse(
                message = cause.message ?: ""
            )
        }
    }

    companion object {
        private const val ENDPOINT_SIGN_UP = "signUp"
        private const val ENDPOINT_SIGN_IN = "signInWithPassword"
        private const val BASE_URL = "https://identitytoolkit.googleapis.com/v1/accounts:"
    }
}