# Voice-Recognition-Identification-System
The two fundamental tasks of project: identification and recognition. The goal of speaker recognition is to recognize a person automatically from his or her voice. 
Methodology : 
• Mel frequency Cepstral Coefficients (MFCCs) have been used for feature extraction. 
    MFCCs are commonly derived as follows:
    Take the Fourier transform of (a windowed excerpt of) a signal.
    Map the powers of the spectrum obtained above onto the mel scale, using triangular overlapping windows.
    Take the logs of the powers at each of the mel frequencies.
    Take the discrete cosine transform of the list of mel log powers, as if it were a signal.
    The MFCCs are the amplitudes of the resulting spectrum.
• Vector quantization technique is used to minimize the amount of data to be handled.
    A simple training algorithm for vector quantization is[citation needed]:
    Pick a sample point at random
    Move the nearest quantization vector centroid towards this sample point, by a small fraction of the distance
    Repeat
    
A more sophisticated algorithm reduces the bias in the density matching estimation, and ensures that all points are used, by including an extra sensitivity parameter[citation needed]:
    Increase each centroid's sensitivity by a small amount
    Pick a sample point P at random
    For each quantization vector centroid, let d(P,c_{i})} {d(P,c_{i})} denote the distance of {P} P and {c_{i}} c_{i}
    Find the centroid for which d(P,c_{i})-s_{i}} d(P,c_{i})-s_{i}} is the smallest
    Move {c_{i}} towards P by a small fraction of the distance
    Set  s_{i} to zero
    Repeat
    
