import com.kcc.kmmhackathon.shared.entity.FirebaseAuthenticationResponse

public interface AuthenticationStore {

    suspend fun signUp(
        apiKey: String,
        email: String,
        password: String,
        returnSecureToken: Boolean
    ): FirebaseAuthenticationResponse

    suspend fun signIn(
        apiKey: String,
        email: String,
        password: String,
        returnSecureToken: Boolean
    ): FirebaseAuthenticationResponse
}