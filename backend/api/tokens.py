from django.contrib.auth.tokens import default_token_generator

# Generate a unique token for the user
token = default_token_generator.make_token(user)
