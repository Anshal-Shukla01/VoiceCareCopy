import React, { useState, useEffect } from 'react';

const VoiceCareSplash = () => {
  const [showSplash, setShowSplash] = useState(true);
  const [fadeIn, setFadeIn] = useState(false);
  const [fadeOut, setFadeOut] = useState(false);

  useEffect(() => {
    // Start fade in immediately
    const fadeInTimer = setTimeout(() => {
      setFadeIn(true);
    }, 100);

    // Start fade out with zoom
    const fadeOutTimer = setTimeout(() => {
      setFadeOut(true);
    }, 2000);

    // Navigate to main screen
    const navigateTimer = setTimeout(() => {
      setShowSplash(false);
    }, 3100);

    return () => {
      clearTimeout(fadeInTimer);
      clearTimeout(fadeOutTimer);
      clearTimeout(navigateTimer);
    };
  }, []);

  if (!showSplash) {
    return <VoiceInputScreen />;
  }

  const logoStyle = {
    opacity: fadeOut ? 0 : (fadeIn ? 1 : 0),
    transform: fadeOut ? 'scale(1.3)' : (fadeIn ? 'scale(1)' : 'scale(0.8)'),
    transition: 'all 1s ease-in-out',
  };

  const glowStyle = {
    opacity: fadeOut ? 0 : (fadeIn ? 0.4 : 0),
    transform: fadeOut ? 'scale(2)' : (fadeIn ? 'scale(1.5)' : 'scale(1)'),
    transition: 'all 1s ease-in-out',
  };

  return (
    <div style={{
      position: 'fixed',
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      backgroundColor: '#121212'
    }}>
      <div style={{ position: 'relative', width: '200px', height: '200px' }}>
        {/* Glow effect behind logo */}
        <div style={{
          position: 'absolute',
          top: '50%',
          left: '50%',
          width: '150px',
          height: '150px',
          marginLeft: '-75px',
          marginTop: '-75px',
          backgroundColor: '#FFD54F',
          borderRadius: '50%',
          filter: 'blur(40px)',
          ...glowStyle
        }} />
        
        {/* Logo container */}
        <div style={{
          position: 'relative',
          width: '100%',
          height: '100%',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          ...logoStyle
        }}>
          <svg width="200" height="200" viewBox="0 0 512 512" fill="none">
            {/* Heart shape outline */}
            <path
              d="M256 448C256 448 64 336 64 176C64 96 112 64 160 64C192 64 224 96 256 144C288 96 320 64 352 64C400 64 448 96 448 176C448 336 256 448 256 448Z"
              stroke="#F4E04D"
              strokeWidth="24"
              fill="none"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
            
            {/* Heartbeat line left */}
            <path
              d="M80 240 L120 240 L140 200 L160 280 L180 240 L220 240"
              stroke="#F4E04D"
              strokeWidth="16"
              fill="none"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
            
            {/* Heartbeat line right */}
            <path
              d="M292 240 L332 240 L352 200 L372 280 L392 240 L432 240"
              stroke="#F4E04D"
              strokeWidth="16"
              fill="none"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
            
            {/* Microphone body */}
            <rect x="220" y="180" width="72" height="100" rx="36" fill="#F4E04D" />
            
            {/* Microphone grille lines */}
            <line x1="236" y1="200" x2="276" y2="200" stroke="#2C3236" strokeWidth="6" strokeLinecap="round" />
            <line x1="236" y1="220" x2="276" y2="220" stroke="#2C3236" strokeWidth="6" strokeLinecap="round" />
            <line x1="236" y1="240" x2="276" y2="240" stroke="#2C3236" strokeWidth="6" strokeLinecap="round" />
            <line x1="236" y1="260" x2="276" y2="260" stroke="#2C3236" strokeWidth="6" strokeLinecap="round" />
            
            {/* Microphone stand */}
            <path
              d="M256 280 L256 320 M220 320 L292 320"
              stroke="#F4E04D"
              strokeWidth="16"
              strokeLinecap="round"
            />
            
            {/* Settings gear icon */}
            <g transform="translate(310, 200)">
              <circle cx="0" cy="0" r="24" fill="none" stroke="#F4E04D" strokeWidth="8" />
              <circle cx="0" cy="0" r="10" fill="#F4E04D" />
              {/* Gear teeth */}
              <rect x="-4" y="-32" width="8" height="12" fill="#F4E04D" rx="2" />
              <rect x="-4" y="20" width="8" height="12" fill="#F4E04D" rx="2" />
              <rect x="20" y="-4" width="12" height="8" fill="#F4E04D" rx="2" />
              <rect x="-32" y="-4" width="12" height="8" fill="#F4E04D" rx="2" />
            </g>
          </svg>
        </div>
      </div>
    </div>
  );
};

const VoiceInputScreen = () => {
  const [isListening, setIsListening] = useState(false);
  const [showMenu, setShowMenu] = useState(false);
  const [notification, setNotification] = useState('');

  const toggleListening = () => {
    setIsListening(!isListening);
  };

  const showNotification = (message) => {
    setNotification(message);
    setTimeout(() => setNotification(''), 2000);
  };

  const handleMenuSelect = (option) => {
    setShowMenu(false);
    showNotification(`${option} selected`);
  };

  return (
    <div style={{
      position: 'fixed',
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      backgroundColor: '#121212',
      display: 'flex',
      flexDirection: 'column'
    }}>
      {/* AppBar */}
      <div style={{
        height: '72px',
        backgroundColor: '#121212',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        padding: '0 16px',
        borderBottom: '1px solid rgba(255, 255, 255, 0.05)'
      }}>
        {/* Menu Button */}
        <div style={{ position: 'relative' }}>
          <button
            onClick={() => setShowMenu(!showMenu)}
            style={{
              background: 'none',
              border: 'none',
              color: 'rgba(255, 255, 255, 0.7)',
              cursor: 'pointer',
              fontSize: '30px',
              padding: '8px'
            }}
          >
            ⋮
          </button>
          
          {/* Dropdown Menu */}
          {showMenu && (
            <div style={{
              position: 'absolute',
              top: '45px',
              left: '0',
              backgroundColor: '#1E1E1E',
              borderRadius: '8px',
              minWidth: '200px',
              boxShadow: '0 4px 12px rgba(0, 0, 0, 0.5)',
              zIndex: 1000
            }}>
              <button
                onClick={() => handleMenuSelect('Health Insights')}
                style={{
                  width: '100%',
                  padding: '12px 16px',
                  border: 'none',
                  backgroundColor: 'transparent',
                  color: 'rgba(255, 255, 255, 0.7)',
                  textAlign: 'left',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '10px',
                  fontSize: '16px'
                }}
                onMouseEnter={(e) => e.target.style.backgroundColor = '#2A2A2A'}
                onMouseLeave={(e) => e.target.style.backgroundColor = 'transparent'}
              >
                <span>💡</span> Health Insights
              </button>
              <button
                onClick={() => handleMenuSelect('Settings')}
                style={{
                  width: '100%',
                  padding: '12px 16px',
                  border: 'none',
                  backgroundColor: 'transparent',
                  color: 'rgba(255, 255, 255, 0.7)',
                  textAlign: 'left',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '10px',
                  fontSize: '16px'
                }}
                onMouseEnter={(e) => e.target.style.backgroundColor = '#2A2A2A'}
                onMouseLeave={(e) => e.target.style.backgroundColor = 'transparent'}
              >
                <span>⚙️</span> Settings
              </button>
            </div>
          )}
        </div>

        {/* Title */}
        <h1 style={{
          color: 'white',
          fontSize: '20px',
          fontWeight: 'bold',
          letterSpacing: '1.5px',
          margin: 0
        }}>
          VOICECARE
        </h1>

        {/* History Button */}
        <button
          onClick={() => showNotification('History tapped')}
          style={{
            background: 'none',
            border: 'none',
            color: 'rgba(255, 255, 255, 0.7)',
            cursor: 'pointer',
            fontSize: '30px',
            padding: '8px'
          }}
        >
          🕐
        </button>
      </div>

      {/* Main Content */}
      <div
        onClick={toggleListening}
        style={{
          flex: 1,
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          justifyContent: 'center',
          cursor: 'pointer'
        }}
      >
        {/* Mic Button with Animation */}
        <div style={{
          position: 'relative',
          width: '190px',
          height: '190px',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          transition: 'all 0.3s ease'
        }}>
          {/* Outer Glow Circle */}
          <div style={{
            position: 'absolute',
            width: '190px',
            height: '190px',
            borderRadius: '50%',
            backgroundColor: 'rgba(255, 215, 0, 0.1)',
            boxShadow: isListening ? '0 0 40px 15px rgba(255, 215, 0, 0.3)' : 'none',
            transition: 'all 0.3s ease'
          }} />

          {/* Inner Yellow Circle */}
          <div style={{
            width: '140px',
            height: '140px',
            borderRadius: '50%',
            backgroundColor: '#FFD700',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            zIndex: 1
          }}>
            <span style={{
              fontSize: '60px',
              color: 'rgba(0, 0, 0, 0.87)'
            }}>
              {isListening ? '🎤' : '🎙️'}
            </span>
          </div>
        </div>

        {/* Status Text */}
        <p style={{
          marginTop: '40px',
          color: 'rgba(255, 255, 255, 0.7)',
          fontSize: '18px'
        }}>
          {isListening ? 'Listening...' : 'Tap anywhere to talk'}
        </p>
      </div>

      {/* Notification Snackbar */}
      {notification && (
        <div style={{
          position: 'fixed',
          bottom: '20px',
          left: '50%',
          transform: 'translateX(-50%)',
          backgroundColor: '#333',
          color: 'white',
          padding: '12px 24px',
          borderRadius: '4px',
          boxShadow: '0 2px 8px rgba(0, 0, 0, 0.3)',
          zIndex: 1000
        }}>
          {notification}
        </div>
      )}
    </div>
  );
};

export default VoiceCareSplash;
