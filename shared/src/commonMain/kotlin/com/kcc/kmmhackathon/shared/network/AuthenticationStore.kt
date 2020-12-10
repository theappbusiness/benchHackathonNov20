import com.kcc.kmmhackathon.shared.entity.FirebaseAuthenticationResponse

public interface AuthenticationStore {

    suspend fun signUp(
        email: String,
        password: String,
        returnSecureToken: Boolean
    ): FirebaseAuthenticationResponse

    suspend fun signIn(
        email: String,
        password: String,
        returnSecureToken: Boolean
    ): FirebaseAuthenticationResponse
}