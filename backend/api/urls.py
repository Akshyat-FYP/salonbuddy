from django.urls import path, include
from rest_framework_simplejwt.views import TokenRefreshView
from api import views


urlpatterns = [
    path("token/", views.MyTokenObtainedPairView.as_view(),name='home'),
    path('users/', views.UserListView.as_view(), name='user_list'),
    path('users/<int:id>/', views.UserDetailView.as_view(), name='user_detail'),
    path("token/refresh/", TokenRefreshView.as_view()),
    path("register/", views.RegisterView.as_view()),
    path("dashboard/", views.dashboard),
    path("login/", views.LoginAPIView.as_view()),
    path('profile/', views.UserProfileView.as_view(), name='user-profile'),
    path('profile/update/', views.ProfileUpdateAPIView.as_view(), name='profile-update'),
    path('profile/image/', views.ProfileImageView.as_view(), name='profile_image'),
    path('barbershops/', views.list_barbershops, name='barbershop-list'),
    path('barbershops/<int:pk>/', views.BarbershopDetailView.as_view(), name='barbershop-detail'),
    path('barbershops/create/<int:userId>/', views.create_barbershop, name='create_barbershop'),
    path('barbershops/<int:pk>/update/', views.update_barbershop, name='barbershop-update'),
    path('barbershops/in-service-barbershops/', views.InServiceBarbershopListView.as_view(), name='in-service-barbershops-list'),
    path('barbershops/<int:pk>/delete/', views.delete_barbershop, name='barbershop-delete'),
    path('barbershops/user/<int:user_id>/', views.get_barbershop_by_user, name='list_barbershops_by_user'),
    path('style-of-cut/<int:pk>/', views.StyleOfCutDetailView.as_view(), name='style-of-cut-detail'),
    path('<int:barbershop_id>/style-of-cut/create/', views.StyleOfCutCreateView.as_view(), name='style-of-cut-create'),
    path('barbershops/<int:barbershop_id>/style-of-cuts/', views.StyleOfCutListView.as_view(), name='style-of-cut-list'),
    path('barbershops/<int:barbershop_id>/style-of-cuts/create-default-styles/', views.create_default_styles, name='create_default_styles'),
    path('barbershops/<int:barbershop_id>/appointments/', views.AppointmentListView.as_view(), name='appointment-list'),
    path('barbershops/<int:barbershop_id>/appointments/create/', views.AppointmentCreateView.as_view(), name='appointment-create'),
    path('barbershops/<int:barbershop_id>/appointments/<int:pk>/', views.AppointmentDetailView.as_view(), name='appointment-detail'),
    path('verified-appointments/<int:user_id>/', views.VerifiedAppointmentsView.as_view(), name='verified_appointments'),
    path('update-device-token/', views.UpdateDeviceTokenView.as_view(), name='update_device_token'),
    path('appointments/<int:pk>/generate-pdf/', views.AppointmentDetailView.as_view(), name='generate_appointment_pdf'),
    path('barber-appointments/<int:barbershop_id>/verified/', views.BarberAppointmentsView.as_view(), name='barber_appointments'),
    path('barbershop/<int:barbershop_id>/barber/create/', views.BarberCreateView.as_view(), name='barber_create'),
    path('barbershop/<int:barbershop_id>/barbers/', views.BarberListView.as_view(), name='barber_list'),
    path('barbershop/<int:barbershop_id>/barbers/<int:barber_id>/', views.BarberDetailView.as_view(), name='barber-detail'),
    path('activate/<uidb64>/<token>/', views.activate_account, name='activate'),
    path('reset-password/<uidb64>/<token>/', views.reset_password_confirm, name='reset_password_confirm'),
    path('reset-password/', views.reset_password, name='reset_password'),


]
