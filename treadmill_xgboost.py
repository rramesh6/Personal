#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Aug 27 19:57:37 2023

@author: Rithvik
"""

import pandas as pd
from xgboost import XGBClassifier
from sklearn.model_selection import train_test_split

data = pd.read_csv('/Volumes/dwang3_shared/Treadmill/Ramp Up/Feature Tables/Power/gait_RCS_02_Treadmill_Ramp_Up_BOTH_STIM_ON_MEDS.csv')
Y = data['Speed']
X = data.drop(columns=['Speed'])

test_size = 0.2;
X_train, X_test, y_train, y_test = train_test_split(X,Y,test_size=test_size,stratify=Y)

model = XGBClassifier()
model.fit(X_train,y_train)

ypred = model.predict(X_test)

