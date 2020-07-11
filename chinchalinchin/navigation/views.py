from django.shortcuts import render

def home_page(request):
    return render(request, 'home.html')

def splash_page(request):
    return render(request, 'splash.html')